Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRE2AJl>; Mon, 28 May 2001 20:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbRE2AJV>; Mon, 28 May 2001 20:09:21 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:27028 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S261837AbRE2AJR>; Mon, 28 May 2001 20:09:17 -0400
Message-ID: <3B12E8B4.238DCD11@idcomm.com>
Date: Mon, 28 May 2001 18:09:24 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.15-config.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: bzdisk broken in 2.4.5?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried on two separate machines to test out 2.4.5 through the "make
bzdisk" boot floppy, and it fails on both (the compile succeeds, but
boot never gets to LILO, it simply gives "400" and a repeating list of
AX, BX, CX, and DX registers). Both are scsi aic7xxx, but use different
controllers, and have scsi directly compiled in. One machine is based on
RH 7.1 beta, the other on RH 7.1. Both are x86 SMP, with motherboard and
all hardware being different. Using the same kernel through a
"mkbootdisk" works, only "make bzdisk" fails. Can anyone here verify
that "make bzdisk" will create a bootable floppy (I did try an entire
box of different floppies) on 2.4.5+? Especially, can anyone verify this
for SMP and/or purely scsi machines? If scsi, do you use aic7xxx?

D. Stimits, stimits@idcomm.com
