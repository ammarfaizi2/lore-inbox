Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291517AbSBHJ5V>; Fri, 8 Feb 2002 04:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291512AbSBHJ5M>; Fri, 8 Feb 2002 04:57:12 -0500
Received: from fw.sthlm.cendio.se ([213.212.13.67]:51702 "EHLO
	jarlsberg.sthlm.cendio.se") by vger.kernel.org with ESMTP
	id <S291510AbSBHJ45>; Fri, 8 Feb 2002 04:56:57 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Cyrix CX5530 audio support?
In-Reply-To: <20020206222540.59011685.thibaut@celestix.com> <E16YTsC-0005R1-00@the-village.bc.nu>
From: Marcus Sundberg <marcus@ingate.com>
Date: 08 Feb 2002 10:56:54 +0100
In-Reply-To: alan@lxorguk.ukuu.org.uk's message of "Wed, 6 Feb 2002 15:20:36 +0000 (GMT)"
Message-ID: <veofj0z47t.fsf@inigo.sthlm.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

> > The sb module from the kernel works.
> > IIRC, sb16 had a hard time detecting the chip (though I haven't tested it again recently), but ALSA snd-card-sb16 is all right so you'll probably want to use the later.
> 
> Its been fine on my CS5530 since 2.2. We have the DMA emulation bug and the
> disable_dma emulation bug fixed up nowdays

But if you have the option I'd recommend to use one of the native
drivers. National have drivers for both OSS and ALSA, and the ALSA
driver is under a BSD license. (The OSS driver I don't know about,
it doesn't say anything about licensing conditions.)

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
