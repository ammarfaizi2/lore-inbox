Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVDEJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVDEJoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVDEJmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:42:49 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:25328 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261664AbVDEJgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:36:23 -0400
Subject: pktcddvd -> immediate crash
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 20:44:11 +0200
Message-Id: <1112640251.5410.30.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I wonder whether anyone could use the pktcddvd device without killing
random jobs (due to sudden out of memory or better memory leaks in
pktcddvd) and finally a complete freeze of the machine ?

To reproduce just create an udf filesystem on some dvdrw, mount it rw
and copy some large file to the mount point.

Do others also see this behaviour and if so is this going to be fixed
soon - or am I alone with that problem ?

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

