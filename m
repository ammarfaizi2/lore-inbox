Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVADVrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVADVrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVADVqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:46:11 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:18174 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262268AbVADVk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:40:29 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:40:28 -0600
Date: Tue, 4 Jan 2005 15:40:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is to remove the last cli()/sti() function calls in arch/ppc.

These are the only instances in active code that grep could find.
