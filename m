Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUJVIHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUJVIHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUJVIH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:07:26 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:33211 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269725AbUJVIHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:07:06 -0400
Subject: [ALPHA 2.6.9] __ioremap gone in include/asm-alpha/io.h
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: Kernel-List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1098432320.30655.8.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 10:05:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.9 __ioremap( ) is gone in include/asm-alpha/io.h resp. the
#define that linked alphas generic ioremap was deleted

Which brakes build on alpha.
Could we revert the cleanup that caused this????
Or complete it ????

Alex 

