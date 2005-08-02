Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVHBPPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVHBPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVHBPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:15:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:64961 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261507AbVHBPPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:15:14 -0400
Date: Tue, 2 Aug 2005 17:15:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: plougher@users.sourceforge.net
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: squashfs seems nfs-incompatible
Message-ID: <Pine.LNX.4.61.0508021710590.4634@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I found out that you cannot mount an exported squash fs. The exports(5) fsid= 
parameter does not help it [like it did with unionfs].


Jan Engelhardt
-- 
