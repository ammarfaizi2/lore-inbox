Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWBQBy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWBQBy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBQBy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:54:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:59590 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750973AbWBQBy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:54:28 -0500
Subject: suspend console gone ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 12:54:02 +1100
Message-Id: <1140141242.3806.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tried to track this down yet, but with recent 2.6.16-git, it
seems that the suspend console is gone... That is, the kernel still
switches VTs from X to some console with no getty on it, but no kernel
message gets displayed at all during the suspend process... looks like
this kmsg_redirect thing isn't working.

Known problem ?

Ben.


