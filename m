Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbRGHRdd>; Sun, 8 Jul 2001 13:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbRGHRdY>; Sun, 8 Jul 2001 13:33:24 -0400
Received: from [194.213.32.142] ([194.213.32.142]:19972 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266934AbRGHRdM>;
	Sun, 8 Jul 2001 13:33:12 -0400
Date: Sat, 30 Jun 2001 13:58:05 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven Walter <srwalter@yahoo.com>, Andy Ward <andyw@edafio.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Message-ID: <20010630135804.A142@toy.ucw.cz>
In-Reply-To: <20010625013241.A23425@hapablap.dyn.dhs.org> <E15EQS6-0001Ft-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15EQS6-0001Ft-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jun 25, 2001 at 08:06:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Great, glad to here it.  Who (if anyone) is still attempting to unravel
> > the puzzle of the Via southbridge bug?  You, Andy, should try and get in
> > touch with them and help debug this thing, if you're up to it.
> 
> The IWILL problem seems unrelated. Its the board that more than others people
> report fails totally when streaming memory copies using movntq instructions.
> 
> The Athlon optimised kernel places pretty much the absolute maximum load 
> possible on the memory bus. Several people have reported that machines that
> are otherwise stable on the bios fast options require  the proper conservative
> settings to be stable with the Athlon optimisations

Do we need patch to memtest to use 3dnow?
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

