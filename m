Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267331AbUG1XeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267331AbUG1XeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUG1Xay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:30:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:5553 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267330AbUG1X1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:27:52 -0400
Subject: 2.6.8-rc2-mm1 link errors
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1091057256.2871.637.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 16:27:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some odd link errors from -rc2-mm1 that don't happen in
-rc1-mm1, or plain -rc2:

          LD      .tmp_vmlinux1
        ldchk: .tmp_vmlinux1: final image has undefined symbols:
        
        
        <bunch of blank lines>
        
        
        make: *** [.tmp_vmlinux1] Error 1
        
Any ideas?

Linux elm3b82 2.6.0-test4-autokern1 #1 SMP Mon Sep 8 08:12:06 PDT 2003
i686 GNU/Linux

Gnu C                  2.95.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1


-- Dave

