Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRFYDuN>; Sun, 24 Jun 2001 23:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265871AbRFYDuD>; Sun, 24 Jun 2001 23:50:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21833 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S265870AbRFYDt5>; Sun, 24 Jun 2001 23:49:57 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pzycrow@hotmail.com (John Nilsson), linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <E15EHkU-0000Wu-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jun 2001 21:45:23 -0600
In-Reply-To: <E15EHkU-0000Wu-00@the-village.bc.nu>
Message-ID: <m1bsndb4to.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > 8: A way to change kernel without rebooting. I have no diskdrive or cddrive 
> > in my laptop so I often do drastic things when I install a new distribution.
> 
> Thats actually an incredibly hard problem to solve. The only people who do
> this level of stuff are some of the telephony folks, and the expensive 
> tandem non-stop boxes.

If you don't care about preserving user space it is a solved problem.

I have a patch that is currently up to 2.4.2 that works on both alpha,
and x86.  Porting to other archtietures also looks very simple.

I wrote it so I can use the linux kernel in conjunction with some
use space code as a bootloader.

Eric
