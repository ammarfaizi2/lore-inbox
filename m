Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVCONlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVCONlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCONlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:41:11 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:14997 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S261221AbVCONhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:37:00 -0500
Date: Tue, 15 Mar 2005 23:36:44 +1000
From: David McCullough <davidm@snapgear.com>
To: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: ocf-linux-20050315 - Asynchronous Crypto support for linux
Message-ID: <20050315133644.GA25903@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

The latest release of ocf-linux (20050315) is available for download
from the project page:

	http://ocf-linux.sourceforge.net/

This release includes the following changes:

	* Hifn PLL bug fixes
	* Makefile fixes for 2.6 builds
	* 2.6.11 and 2.4.29 patches
	* cleanups for x86 builds

OCF-Linux is a Linux port of the OpenBSD/FreeBSD Cryptographic Framework
(OCF). This port aims to bring full asynchronous HW/SW crypto
acceleration to the Linux kernel and applications running under Linux.
Results have shown improvements of up to 7 times that of software crypto
for bulk crypto throughput using OpenSSL.

At this point in time OCF-Linux provides acceleration for OpenSSL,
OpenSSH (scp, ssh, ...) and also supports the BSD crypto testing
applications. It can accelerate DES, 3DES, AES, MD5, SHA, and Public Key
operations with plans to include Random Number generators and more. This
project is being actively developed as a high performance crypto
solution for embedded devices but also applies equally well to any linux
based server or desktop.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
