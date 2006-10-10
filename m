Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWJJPjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWJJPjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWJJPjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:39:11 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:44901 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S932161AbWJJPjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:39:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAPpaK0WMEgIN
X-IronPort-AV: i="4.09,291,1157320800"; 
   d="scan'208"; a="4088893:sNHT30000288"
Date: Tue, 10 Oct 2006 17:39:08 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 02/02 V3] net/ipv6: seperate sit driver to extra module (addrconf.c changes)
Message-ID: <20061010153908.GB27455@zlug.org>
References: <20061010153745.GA27455@zlug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010153745.GA27455@zlug.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the changes to net/ipv6/addrconf.c to remove sit
specific code if the sit driver is not selected.

Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>
Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
