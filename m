Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270817AbTGVMpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270819AbTGVMpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:45:30 -0400
Received: from h-64-236-243-31.twi.com ([64.236.243.31]:51335 "EHLO
	atwburmw02.twi.com") by vger.kernel.org with ESMTP id S270817AbTGVMp3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:45:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: vmalloc - kmalloc and page locks
Date: Tue, 22 Jul 2003 06:00:14 -0700
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: vmalloc - kmalloc and page locks
Thread-Index: AcNQUTNczGXwmb+PT46a3OT+oV2kHA==
From: "Deas, Jim" <James.Deas@warnerbros.com>
To: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 22 Jul 2003 13:00:14.0620 (UTC)
 FILETIME=[314CDDC0:01C35051]
X-WSS-ID: 1303EAD4207562-01-02
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <S270817AbTGVMp3/20030722124529Z+5562@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I look at what memory are being paged out of memory in the kernel
or how to lock kmalloc and vmalloc pages so they do not get put to swap?
 I have a program that runs great 90% of the time but the other 10%
of the time the system usage (using 'top')goes from 3% to 50% and latency goes out
the window!  I am assuming this is due to some of my buffers getting swaped 
out as it often corrects itself and runs well the majority of time.
Doubling the base memory from 256M to 512M did nothing to fix this.
I need some way to find out who is holding up the process.
Any suggestions? linux-newbe did not give me any replys, if
this is the wrong groups can someone redirect me?

Best Regards,
J. Deas

