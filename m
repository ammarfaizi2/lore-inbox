Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUCLOD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUCLOD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:03:29 -0500
Received: from [202.125.86.130] ([202.125.86.130]:27808 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262119AbUCLOD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:03:27 -0500
Subject: compiling for SMP!
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 12 Mar 2004 19:29:23 +0530
Message-ID: <1118873EE1755348B4812EA29C55A972176549@esnmail.esntechnologies.co.in>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-TNEF-Correlator: 
Thread-Topic: compiling for SMP!
Thread-Index: AcQIOEo3oMKRqGrSR2KbB8h65Gh9XAAAUw4Q
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Chandrashekhar Reddy.N" <chandrashekharn@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a device driver that compiles fine on the uni-processor
environment. 
INCDIR=/usr/src/linux-2.4/include.

I was trying to compile the same module in SMP machine with -D__SMP__
-DCONFIG_SMP flags extra for CFLAGS
in the Makefile, but I end up with compilation error! Following is the
error..

In file Included from /usr/src/linux-2.4/include/asm/hw_irq.h In
function x86_do_profile:
         Current undeclared.

I included linux/interrupt.h in my source file.

What could be the problem? Are there some other flags I should use for
compilation in SMP machine?

Any pointers on this would be of great help!

Thanks in advance
Chandu!

 
