Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284289AbRLMPzu>; Thu, 13 Dec 2001 10:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284301AbRLMPzk>; Thu, 13 Dec 2001 10:55:40 -0500
Received: from [212.3.242.3] ([212.3.242.3]:33038 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S284289AbRLMPzW>;
	Thu, 13 Dec 2001 10:55:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: User/kernelspace stuff to set/get kernel variables
Date: Thu, 13 Dec 2001 16:54:05 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011213155532Z284289-18284+114@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I've been looking on the web, and couldn't really find what i would want...

Basically: is it possible to - one way or another - set variables at kernel boot and read those using userspace utilities?

for instance: i boot my kernel (using any old bootmanager that accepts kernel params)


LILO: linux network=dhcp


and later, in the init scripts, i check the value of this variable using some sort of userspace program, and if it happends to be 'dhcp' i'll invoke the dhcp client. 
Otherwise i'd just give a static address.

I have other uses for this, for instance, you want your disks to be FSCK'ed, but don't wanna boot first, or, don't wanna go in single user mode


LILO: linux dofsck=true


Does something like this exist? Is it implementable in an easy way? (I know a few programming languages, but only little C(++)....)

Thanks


DK
