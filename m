Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265227AbRFUVLE>; Thu, 21 Jun 2001 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265229AbRFUVKy>; Thu, 21 Jun 2001 17:10:54 -0400
Received: from cpe126.netz6.cablesurf.de ([195.206.156.126]:1159 "EHLO
	idun.neukum.org") by vger.kernel.org with ESMTP id <S265227AbRFUVKu>;
	Thu, 21 Jun 2001 17:10:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Abramo Bagnara <abramo@alsa-project.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Is it useful to support user level drivers
Date: Thu, 21 Jun 2001 23:09:04 +0200
X-Mailer: KMail [version 1.2]
Cc: "D.A.Fedorov@inp.nsk.su Balbir Singh" <balbir_soni@yahoo.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15D8Ec-0001lL-00@the-village.bc.nu> <3B325206.3EB44DDD@alsa-project.org>
In-Reply-To: <3B325206.3EB44DDD@alsa-project.org>
MIME-Version: 1.0
Message-Id: <01062123090407.02500@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Kernel space:
> - irq 9 arrives from our device
> - interrupts are disabled
> - our kernel space micro handler is invoked
> - interrupt source is checked
> - if no notification is pending a signal is notificated for user space
> (or a process is marked runnable)
> - optionally our device interrupt generation is disabled
> - handler returns
> - interrupts are enabled

Then why bother ? Write a minimum conventional kernel driver implementing 
poll()

	Regards
		Oliver
