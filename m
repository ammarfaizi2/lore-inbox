Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTFEGuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 02:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTFEGuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 02:50:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:63484 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264465AbTFEGuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 02:50:18 -0400
Date: Thu, 5 Jun 2003 15:03:35 +0800
From: hv-it <hv@trust-mart.com.cn>
To: linux-kernel@vger.kernel.org
Subject: megaraid in 2.5.70
Message-Id: <20030605150335.4acdc174.hv@trust-mart.com.cn>
Organization: gmo
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all:
   megaraid's driver in 2.5.70 can make swapper pannic at boot time.So I copy 2.5.69's megaraid.c and megaraid.h to 2.5.70,all is right.I found that  "memset(mbox, 0, sizeof(mbox));" in 2.5.70 and " memset(mbox, 0, sizeof(mbox));" in 2.5.69,I wondered whether it's the pannic source.
