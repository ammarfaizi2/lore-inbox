Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRLZOsP>; Wed, 26 Dec 2001 09:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLZOsG>; Wed, 26 Dec 2001 09:48:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280537AbRLZOry>; Wed, 26 Dec 2001 09:47:54 -0500
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
To: pboley@home.com (Paul Boley)
Date: Wed, 26 Dec 2001 14:58:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C295D5C.50EE365D@home.com> from "Paul Boley" at Dec 26, 2001 12:17:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JFVe-00024J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>              total       used       free     shared    buffers
> cached
> Mem:        417472     412192       5280          0      20632
> 315680

Thyose values dont show any problems. In fact your machine seems to think it
had a ton of free memory to waste and has let it fill up with stuff that has
been accessed - just on the chance that it may be reused.

It hasn't even felt enough memory pressure to start swapping. When you 
say it "becomes slow", what precisely becomes slow ?

Also what disks do you have and how are they set up ?
