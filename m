Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278380AbRJMTeL>; Sat, 13 Oct 2001 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278379AbRJMTd4>; Sat, 13 Oct 2001 15:33:56 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:14340 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278381AbRJMTdh>;
	Sat, 13 Oct 2001 15:33:37 -0400
Date: Mon, 8 Oct 2001 16:44:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
Message-ID: <20011008164436.D79@toy.ucw.cz>
In-Reply-To: <Pine.LNX.3.96.1011007173411.6774A-100000@artax.karlin.mff.cuni.cz> <E15qLzV-00071D-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15qLzV-00071D-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 07, 2001 at 11:01:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The difference between memory and vmalloc space is this: you fill up the
> > whole memory with cache => memory fragments. You don't fill up the whole
> > vmalloc space with anything => vmalloc space doesn't fragment.
> 
> vmalloc space fragments. You fragment address space rather than pages thats
> all. Same problem

vmalloc space tends to be empty while ram tends to be full. That might be
important.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

