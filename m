Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVAEBr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVAEBr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAEBpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:45:12 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:64204 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262105AbVAEBjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:39:42 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, dev-etrax@axis.com
Cc: starvik@axis.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105014001.22177.28259.66716@localhost.localdomain>
Subject: [PATCH 0/2] cris: remove cli()/sti() from arch/cris/*
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 19:39:41 -0600
Date: Tue, 4 Jan 2005 19:39:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is to remove the last cli()/sti() function calls in arch/cris.

These are the only instances in active code that grep could find.

 drivers/gpio.c     |   24 ++++++++++++------------
 kernel/fasttimer.c |   41 +++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 36 deletions(-)
