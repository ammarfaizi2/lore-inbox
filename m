Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVAGPon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVAGPon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVAGPom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:44:42 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:19429 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261469AbVAGPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:43:54 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200501071543.j07FhrPt007757@clem.clem-digital.net>
Subject: 2.6.10-bk10 fails compile -- kernel/sys.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Fri, 7 Jan 2005 10:43:53 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:

kernel/sys.c: In function `sys_setsid':
kernel/sys.c:1078: `tty_sem' undeclared (first use in this function)
kernel/sys.c:1078: (Each undeclared identifier is reported only once
kernel/sys.c:1078: for each function it appears in.)
make[1]: *** [kernel/sys.o] Error 1

-- 
Pete Clements 
