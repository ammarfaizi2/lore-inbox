Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWHDJav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWHDJav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHDJav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:30:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16531 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030256AbWHDJau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:30:50 -0400
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A
	cpu controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
In-Reply-To: <20060803224253.49068b98.akpm@osdl.org>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 10:49:10 +0100
Message-Id: <1154684950.23655.178.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 22:42 -0700, ysgrifennodd Andrew Morton:
> The downside to such a strategy is that there is a risk that nobody ever
> gets around to implementing useful controllers, so it ends up dead code. 
> I'd judge that the interest in resource management is such that the risk of
> this happening is low.

I think the risk is that OpenVZ has all the controls and resource
managers we need, while CKRM is still more research-ish. I find the
OpenVZ code much clearer, cleaner and complete at the moment, although
also much more conservative in its approach to solving problems.

Alan

