Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRDUSxY>; Sat, 21 Apr 2001 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132824AbRDUSxO>; Sat, 21 Apr 2001 14:53:14 -0400
Received: from [62.225.70.66] ([62.225.70.66]:42247 "EHLO rerecognition.com")
	by vger.kernel.org with ESMTP id <S132822AbRDUSw5>;
	Sat, 21 Apr 2001 14:52:57 -0400
From: "Tamas Nagy" <nagytam@rerecognition.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Idea: Encryption plugin architecture for file-systems
Date: Sat, 21 Apr 2001 20:52:51 +0200
Message-ID: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lot of people would like to know their data in secure place, and the
frequent usage of compression softwares could be time-consuming and boring
sometime.

Idea:
extend the current file-system with an optional plug-in system, which allows
for file-system level encryption instead of file-level. This could be used
transparently for applications or even for file-system drivers.  This
doesn't mean an encrypted file-system, but a transparent encryption of a
media instead.

Advantages:
#1: optional security level for every data, without user interaction.
#2: if this idea is used e.g. for portable media (like cdrom), your backup
could be in safe also.
#3: (almost;)) everybody could create own security plugin for their data,
and not have to trust on the designers of a secure file systems.

I suspect that this idea may appeared in the past:(, but I haven't heard
about it;).

So, what do you think about this? Is Linux kernel enough flexible to do
this? What changes are necessary to do such a thing? Is there any other way,
to have own security for file-systems or portable medias? Is this
implementation could be used in the US?

Best regards,
Tamas Nagy




