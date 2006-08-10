Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWHJGex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWHJGex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWHJGex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:34:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:16870 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161087AbWHJGew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:34:52 -0400
Date: Thu, 10 Aug 2006 08:34:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: sam@ravnborg.org
Subject: CONFIG_NETDEVICES does not do anything
Message-ID: <Pine.LNX.4.61.0608100831580.10926@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


when deselecting CONFIG_NETDEVICES, many selectable items (PHY device 
support, Ethernet 10/100/1000/10000) stay in place. Is there a reason they 
are lacking 'depends on NETDEVICES' or did I found a bug^W glitch?

Jan Engelhardt
-- 
