Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVAKVo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVAKVo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVAKVmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:42:38 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:62367 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262883AbVAKViD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:38:03 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050111213822.9249.15075.83475@localhost.localdomain>
Subject: [PATCH 0/2] frv: replace some cli()/sti() in arch/frv/*
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Tue, 11 Jan 2005 15:38:02 -0600
Date: Tue, 11 Jan 2005 15:38:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches will replace all but one of the cli()/sti() pairs in arch/frv.

The one left is a little too tough for me to figure out (in arch/frv/kernel/irq.c).
I leave that one for someone more skilled ;)
