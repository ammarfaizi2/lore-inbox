Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUIPOpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUIPOpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPOpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:45:00 -0400
Received: from [202.125.86.130] ([202.125.86.130]:9626 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S268119AbUIPOoi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:44:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Having problem with mmap system call!!!
Date: Thu, 16 Sep 2004 20:12:24 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107910@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Having problem with mmap system call!!!
Thread-Index: AcSb+2EiEEvukQNxSwqZFq35XS5RBQ==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
 
I have a doubt about mmap system call.
 
We have developed a character driver for Camera device. We used mmap system call in the application code to map the kernel image buffer pointer to user process with out implementing any mmap call back function in the driver code. No compilation and/or run time error. But, we are not getting the image in the proper way. When we try to open the saved file in paintbrush it shows only junk (i.e. some parallel lines.) Please find the attached zip file. Camera is working fine. We have taken pictures from Windows Machine with good clarity.
 
My doubt is, is it compulsory to implement the call back function in the driver code? OR Is it taken care by File system level functions?
 
Any help greatly appreciated.
 
Thanks and regards,
Srinivas G
 
 

