Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264580AbVBDTRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264580AbVBDTRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVBDTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:17:15 -0500
Received: from user-119bnkd.biz.mindspring.com ([66.149.222.141]:42394 "EHLO
	pxtvjoweb01.primeexalia.com") by vger.kernel.org with ESMTP
	id S264580AbVBDTRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:17:05 -0500
Message-ID: <1107544219.4203c89bdfa6a@www.adndrealm.net>
Date: Fri,  4 Feb 2005 11:10:19 -0800
From: Gary Smith <linuxkernel@adndrealm.net>
To: linux-kernel@vger.kernel.org
Subject: Post install 2.4.29 causes many apps to seg fault.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 171.161.160.10
X-WebMail-Provided-By: Prime Exalia Technologies (http
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have been running RHEL3 update 3 for some time and need to patch netfilter 
for PPTP.  After doing so and installing the kernel I found that certain 
applications (such as MySQL, nslook, etc) began to segfault.  Rolling the 
kernel back fixed the problem.

I have since then gone back and recompiled the vanilla 2.4.29 kernel (without 
additing any patches this time - clean from tarball) and installed it and all 
of the the applications that failed on the custom kernel (with the PPTP 
patches) continue to fail (clean box as well).

Is there something more that I need to compile besides the kernel for 
compatability or is this a sign of some type of bug.  I do realize that RHEL3 
itself has some proprietary items added to their kernel but replacing it 
shouldn't make other applications fails.

Any assistance would be greatly appreciated.

Gary Smith


