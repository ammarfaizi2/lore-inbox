Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbULECSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbULECSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbULECSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:18:44 -0500
Received: from omr3.netsolmail.com ([216.168.230.164]:53977 "EHLO
	omr3.netsolmail.com") by vger.kernel.org with ESMTP id S261226AbULECSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:18:43 -0500
From: <evt@texelsoft.com>
Message-Id: <200412050218.CGU06546@ms3.netsolmail.com>
Date: Sat, 4 Dec 2004 21:18:42 -0500
Subject: How to cause ioremap to map a different fb to the same va?
To: linux-kernel@vger.kernel.org
X-Mailer: Webmail Mirapoint Direct 3.2.2-GA
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to framebuffer cards and if one fails, I'd like to call
ioremap for the second one so that the same virtual address
results to that clients who've mmap'ed the framebuffer are
undisturbed. The 2nd card wouldn't be used until the first one
has a problem and they are identical. Advice? tia.

-evt
