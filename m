Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbUAHW5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266367AbUAHW5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:57:01 -0500
Received: from imh.informatik.uni-bremen.de ([134.102.224.4]:11955 "EHLO
	imh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S266359AbUAHW5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:57:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: New FBDev patch
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Date: Thu, 8 Jan 2004 23:56:46 +0100
Message-Id: <E1Aej55-0000TK-Ay@legolas>
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel James Simmons wrote:
> This is the latest patch against 2.6.0-rc3. Give it a try.

Radeon 7500 (r100) with your patch on top of 2.6.1-rc3:
This fixes the "scheduling while atomic" oops when viewing a picture on
fbcon with fbi (recorded as #879, which I just marked as fixed). Thanks.

However, there's a regression with radeonfb: I get a slight visual corruption
with the cursor: It's a full white blinking block with some pixels left black.
