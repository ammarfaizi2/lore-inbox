Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280257AbRKIWrc>; Fri, 9 Nov 2001 17:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280258AbRKIWrW>; Fri, 9 Nov 2001 17:47:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63756 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280257AbRKIWrN>; Fri, 9 Nov 2001 17:47:13 -0500
Subject: Re: RedHat 2.4.7 & 2.4.9-13 Poweroff failure
To: mdiwan@wagweb.com (Madhav Diwan)
Date: Fri, 9 Nov 2001 22:51:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mdiwan@wagweb.com (Madhav Diwan)
In-Reply-To: <3BEC5B59.7D29E401@wagweb.com> from "Madhav Diwan" at Nov 09, 2001 05:40:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162KUk-0004X7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RedHats newest kernels  2.4.7, and 2.4.9-13 seem to have the same
> problem that RedHat had in 2.4.2 .. they will do everything  including
> shutting down the backlight and .. it sound like they release the drive
> as well.. but they do not let go of the battery.. on a laptop that is a
> BAD thing.
> 
>  any hints?

I'd take a guess that Red Hat and Mandrake base kernels use different APM
options.  If so then its another box to add to the magic dmi list 8)

Jeff - does Mandrake default to APM interrupts enabled ?
