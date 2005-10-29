Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVJ2FrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVJ2FrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVJ2FrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:47:25 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:23179 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751006AbVJ2FrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:47:24 -0400
Message-Id: <20051029060216.159380000@localhost.localdomain>
Date: Sat, 29 Oct 2005 14:02:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 00/13] Adaptive read-ahead V5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version of adaptive read-ahead patch features various clean ups.
Changes include:
	- rewrote context based method to make it clean and robust
	- improved accuracy of stateful thrashing threshold estimation
	- nr_page_aging made right
	- sorted out the thrashing protection logic
	- enhanced debug/accounting facilities

Regards,
Wu Fengguang
