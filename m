Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWGESit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWGESit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWGESit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:38:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31912
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964823AbWGESit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:38:49 -0400
Date: Wed, 05 Jul 2006 11:39:11 -0700 (PDT)
Message-Id: <20060705.113911.112605950.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 on SPARC64 compile fails
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607041417.k64EHNIT009599@laptop11.inf.utfsm.cl>
References: <200607041417.k64EHNIT009599@laptop11.inf.utfsm.cl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Tue, 04 Jul 2006 10:17:23 -0400

> Looking at the relevant file, it seems the offending functions are for PCI
> only (and my SparcStation Ultra 1 sure doesn't have any PCI in it, so this
> is disabled in the configuration). Maybe the #endif is too early?

Yes, I'm still thinking how to fix this.

Turn CONFIG_PCI on as a workaround for now.
