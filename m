Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbREPBFU>; Tue, 15 May 2001 21:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbREPBFK>; Tue, 15 May 2001 21:05:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50194 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261743AbREPBFF>; Tue, 15 May 2001 21:05:05 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B01D239.4C5F1607@transmeta.com>
Date: Tue, 15 May 2001 18:04:57 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151345410.2569-100000@penguin.transmeta.com> <01051603014903.00406@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Sounds like "treat it like a file and it acts like a file, treat it
> like a directory and it acts like a directory".
> 

The original plan was that you only could indirect through it; not
chdir() for example.  One could do the whole enchilada, but then one
would have to expect that open() could have very different effects with
and without O_DIRECTORY (and open() on directories without O_DIRECTORY
should be outlawed with prejudice.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
