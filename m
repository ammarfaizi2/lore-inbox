Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWBVAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWBVAji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBVAjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:39:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16560
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422646AbWBVAjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:39:36 -0500
Date: Tue, 21 Feb 2006 16:39:35 -0800 (PST)
Message-Id: <20060221.163935.32626284.davem@davemloft.net>
To: david@gibson.dropbear.id.au
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060222001359.GA23574@localhost.localdomain>
References: <20060222001359.GA23574@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2006 11:13:59 +1100

> Quite some time ago, I found (by inspection) an ia64 specific bug
> related to its non-contiguous user address space.  I've never done
> anything about it, because I don't have an ia64 to test on - but
> somebody should fix it.  Recently I've spotted another possible bug,
> also by inspection - I don't know enough about ia64 to tell if it's a
> real problem or not.

Good catch David, I'll need to add similar checks on sparc64 as
we have a 64-bit virtual address space hole on several processors
there.
