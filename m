Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUHRSeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUHRSeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHRSeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:34:01 -0400
Received: from mr01.conversent.com ([216.41.101.18]:62080 "EHLO
	mr01.conversent.net") by vger.kernel.org with ESMTP id S267466AbUHRScL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:32:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Is it possible to have a Kernel & initrd in 1 binary?
Date: Wed, 18 Aug 2004 14:32:07 -0400
Message-ID: <E8F8DBCB0468204E856114A2CD20741F1A92F8@mail.local.ActualitySystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is it possible to have a Kernel & initrd in 1 binary?
thread-index: AcSFUarPq88nNu/tRRO/kRsuez0cDA==
From: "Dave Aubin" <daubin@actuality-systems.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
  I'm working on an embedded device and I want it to boot off of a USB
stick.
I'm using a utility called filo which is able to read an elf off of a
USB stick.  The
problem is filo can only read the kernel portion of the elf and not the
initrd.
  Question, is there a way to bundle both the kernel and initrd in to
just a kernel
binary?  I thought there was a way, but I've always used initrd and I'm
not familiar with
making a kernel & initrd in to one image.
  An alternative might be that the kernel be built to understand the
USB, but I've
found that there is a delay between when the kernel detects USB and when
it goes to boot off of the USB drive of about 1 second and then the
kernel fails
to load thinking the USB drive is not present.
  Any help is appreciated.
 
Thanks,
Dave

