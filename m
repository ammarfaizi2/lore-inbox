Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUIWQs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUIWQs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWQpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:45:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18428 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268165AbUIWQnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:43:35 -0400
Subject: Re: [Lhns-devel] [PATCH][1/4] Add unregister_node() to
	drivers/base/node.c
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: anil.s.keshavamurthy@intel.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	 <20040920094719.H14208@unix-os.sc.intel.com>
	 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
	 <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1095957796.21153.94.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 09:43:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 09:31, Keiichiro Tokunaga wrote:
> -int __init register_node(struct node *node, int num, struct node *parent)
> +int register_node(struct node *node, int num, struct node *parent)

__devinit, please.

-- Dave

