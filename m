Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWJWBZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWJWBZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWJWBZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:25:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28073 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751033AbWJWBZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:25:02 -0400
From: Neil Brown <neilb@suse.de>
To: "Randy.Dunlap" <randy.dunlap@oracle.com>
Date: Mon, 23 Oct 2006 11:24:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17724.6624.109124.643899@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] raid: fix printk format warnings
In-Reply-To: message from Randy.Dunlap on Saturday October 21
References: <20061021113406.535d8243.randy.dunlap@oracle.com>
	<17722.60989.448470.587430@cse.unsw.edu.au>
	<453AFE24.706@oracle.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday October 21, randy.dunlap@oracle.com wrote:
> 
> I've only seen it on powerpc64.  It could well be a gcc problem AFAICT.
> Feel free to drop it.  Thanks for the discussion.

I think it is a gcc problem, but it is harmless to work around it, so
I'll take the patch.  Reducing warnings is a good idea.

Thanks,
NeilBrown
