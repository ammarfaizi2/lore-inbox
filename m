Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284078AbRLALuS>; Sat, 1 Dec 2001 06:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284076AbRLALuO>; Sat, 1 Dec 2001 06:50:14 -0500
Received: from mailbox.univie.ac.at ([131.130.1.27]:63195 "EHLO
	mailbox.univie.ac.at") by vger.kernel.org with ESMTP
	id <S284078AbRLALtz>; Sat, 1 Dec 2001 06:49:55 -0500
Message-Id: <200112011149.fB1BnpR198914@mailbox.univie.ac.at>
Content-Type: text/plain; charset=US-ASCII
From: Thomas Hofer <th@monochrom.at>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: small feature request
Date: Sat, 1 Dec 2001 12:49:34 +0100
X-Mailer: KMail [version 1.3]
In-Reply-To: <3C0822EB.3E4C4852@isn.net> <3C083794.2D6C8825@mvista.com>
In-Reply-To: <3C083794.2D6C8825@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote (Samstag, 1. Dezember 2001 02:51):
> "Garst R. Reese" wrote:
> > Would it possible to put a header on System.map indicating the
> > kernel version?
> > Sometimes my little brain forgets what kernel System.old is for.
> > Thanks, Garst
> > -
>
> Just name it: System.map.2.4.16-xx (where xx is the build number) 
> This is easy to automate in your install script.  Then real system
> map is "ln -s"ed to the correct file.

If you have multiple kernels in /boot, name it System.map-2.x.xx-xxxx 
and let booting kernel decide on his own which map to take. No need for 
a symlink. If there's a /boot/System.map the kernel will ignore all the 
other maps.

Thomas.
