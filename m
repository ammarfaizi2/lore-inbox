Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTH1UhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTH1UhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:37:18 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:32167 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264251AbTH1UhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:37:17 -0400
Subject: IDE and LBA48 clipping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062102990.24982.55.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 28 Aug 2003 21:36:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok - Bart pointed out the worst case scenario I worried about can't
actually occur unless you move a disk between controllers. I've included
the basic clipping change from Erik in the patches I've pushed Marcelo
pending the LBA48 DMA bits. 

