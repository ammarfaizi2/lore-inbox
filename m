Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVA2LX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVA2LX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 06:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVA2LX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 06:23:56 -0500
Received: from ozlabs.org ([203.10.76.45]:30933 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262896AbVA2LXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 06:23:54 -0500
Date: Sat, 29 Jan 2005 22:20:03 +1100
From: Anton Blanchard <anton@samba.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix large allocation in nfsd init
Message-ID: <20050129112003.GA8654@krispykreme.ozlabs.ibm.com>
References: <20050127033104.GA26367@krispykreme.ozlabs.ibm.com> <16888.26607.936790.611539@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16888.26607.936790.611539@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Neil,

> Given that the purpose of this order-5 allocation is to provide
> storage for 1024 "struct svc_cacherep" structs, it would seem that a
> better approach would be to just do 1024 kmallocs.
> 
> I'll try to knock a patch together in next week sometime.

That works for me.

Anton
