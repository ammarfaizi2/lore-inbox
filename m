Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVAKVmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVAKVmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVAKVlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:41:39 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:37118 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262889AbVAKVjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:39:11 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dhowells@redhat.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050111213927.9256.16501.54102@localhost.localdomain>
Subject: [PATCH 0/2] frv: replace some cli()/sti() in arch/frv/*
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Tue, 11 Jan 2005 15:39:07 -0600
Date: Tue, 11 Jan 2005 15:39:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches will replace all but one of the cli()/sti() pairs in arch/frv.

The one left is a little too tough for me to figure out (in arch/frv/kernel/irq.c).
I leave that one for someone more skilled ;)
