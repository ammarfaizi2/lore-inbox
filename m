Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277161AbRJUX2B>; Sun, 21 Oct 2001 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277268AbRJUX1v>; Sun, 21 Oct 2001 19:27:51 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:52492 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S277161AbRJUX1j>; Sun, 21 Oct 2001 19:27:39 -0400
Message-ID: <3BD35A0A.41929F49@eisenstein.dk>
Date: Mon, 22 Oct 2001 01:28:10 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/kernel/tainted does not seem to work as intended
In-Reply-To: <E15vS0f-0008Ks-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > with X) and the nVidia drivers load as X is started, I check
> > /proc/sys/kernel/tainted and find that it is still 0. Since the nVidia
> > drivers are binary only and not GPL shouldn't /proc/sys/kernel/tainted
> > be 1 (or at least != 0) ???
> 
> It depends if your modutils are current - the work is done in the modutils
> not the kernel

Ahh, thank you for that piece of info. 
I use modutils 2.4.6 and I just found a modutils changelog and it seems
that the "tainted" stuff was not added until 2.4.9.

I'll get my modutils up to date.


/Jesper Juhl
