Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753589AbWKDFGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbWKDFGL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 00:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbWKDFGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 00:06:11 -0500
Received: from poczta1.linux.webserwer.pl ([193.178.241.18]:39045 "EHLO
	poczta1.linux.webserwer.pl") by vger.kernel.org with ESMTP
	id S1753589AbWKDFGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 00:06:10 -0500
Message-ID: <454C1F84.9010601@limcore.pl>
Date: Sat, 04 Nov 2006 06:05:08 +0100
From: "lkml-2006i-ticket@limcore.pl" <lkml-2006i-ticket@limcore.pl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Simple module for 2.6 request?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
it is not so easy to find online an *working* example of how to by hand
build a module.

gcc -o foo.c -ko foo.ko -DMODULE -D__KERNEL__
-I/usr/src/kernel-headers-directory/include/

with module license define macro

almost worked, but it misses thoes extra symbols created in
post-compilation.

How to add them by hand (not using all the big Makefiles normally
included in kernel tree)?

Like
some-command foo.ko foo.c
insmod foo.ko
done



-- 
LimCore    C++ Software Architect / Team Lead
---> oo    Linux programs
limcore
software


