Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270250AbUJTCda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270250AbUJTCda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbUJTCdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:33:23 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:48324 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270286AbUJTCcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:32:47 -0400
Date: Tue, 19 Oct 2004 19:32:43 -0700
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] uml: process_kern.c --- remove unused label
Message-ID: <20041020023243.GB8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused label/warning

Signed-off-by: cw@f00f.org

diff -Nru a/arch/um/kernel/tt/process_kern.c b/arch/um/kernel/tt/process_kern.c
--- a/arch/um/kernel/tt/process_kern.c	2004-10-19 17:48:11 -07:00
+++ b/arch/um/kernel/tt/process_kern.c	2004-10-19 17:48:11 -07:00
@@ -305,7 +305,6 @@
 
 	change_sig(SIGUSR1, 0);
 	err = 0;
- out:
 	return(err);
 }
 
