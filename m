Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUDFMPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUDFMPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:15:32 -0400
Received: from mta11.adelphia.net ([68.168.78.205]:22668 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S263571AbUDFMPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:15:31 -0400
Date: Tue, 6 Apr 2004 07:42:12 -0400 (EDT)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
X-X-Sender: hirsch@atx.fast.net
To: linux-kernel@vger.kernel.org
Subject: Parport non-functional in 2.6.5
Message-ID: <Pine.LNX.4.44.0404060739050.3018-100000@atx.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Title says it.  Vanilla 2.6.5 kernel built with the same .config options
as its predecessor (2.6.4, which prints just fine over parport).  My
HP2200 is being properly detected by the parport probe, but no output ever
reaches it.

I've temporarily switched to a USB connection, which works fine.  
Reverting the patches to parport_pc.c and lp.c failed to restore 
operation.


Steve


