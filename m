Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWGLWK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWGLWK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWGLWK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:10:27 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:7181 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932465AbWGLWK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:10:27 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Will there be Intel Wireless 3945ABG support?
Date: Wed, 12 Jul 2006 15:09:22 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEEONCAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <44B443E4.1000707@linux.intel.com>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 12 Jul 2006 15:04:43 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 12 Jul 2006 15:04:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also if the binary only chunk of code is neccessary to make the open
> source bit work then its a derivative work as I understand the
> situation,

	The issue is not whether the userspace daemon is a derivative work of any
GPL'd work and therefore must be covered. The issue is whether the kernel
driver and the userspace program are one work or two. If neither is any use
without the other, and the two were designed together, it seems implausible
to argue that they are two works.

	A boundary that consists of an API that allows the work on either side to
be interchanged with others and the other work still operate substantially
the same can certainly divide two works. That's why a C program that uses
the standard library can be a separate work from the standard library. Any C
program works with that library, and the library works with any C program.

	A boundary custom designed for these two programs, and which is not
intended to allow either program to be replaced with another, would not seem
to do the job.

	DS


