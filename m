Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVAHRDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVAHRDu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAHRDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:03:50 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:6072 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261217AbVAHRDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:03:49 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:03:46 -0600
Date: Sat, 8 Jan 2005 11:03:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is to remove the last cli()/sti() function calls in
arch/ppc, and add spinlocks where necessary.

These are the only instances in active code that grep could find.
