Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUK2URX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUK2URX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUK2URX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:17:23 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9965 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261578AbUK2URU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:17:20 -0500
To: Doug Maxey <dwm@austin.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 3/10 CKRM: Core ckrm, rcfs 
In-reply-to: Your message of Mon, 29 Nov 2004 14:00:56 CST.
             <200411292000.iATK0uuD003049@falcon10.austin.ibm.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1442.1101759283.1@us.ibm.com>
Date: Mon, 29 Nov 2004 12:14:43 -0800
Message-Id: <E1CYrv1-0000NJ-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 14:00:56 CST, Doug Maxey wrote:
> 
> On Mon, 29 Nov 2004 10:47:32 PST, Gerrit Huizenga wrote:
> >+extern struct rcfs_mfdesc *genmfdesc[]; 
> >+ 
> >+inline struct rcfs_inode_info *RCFS_I(struct inode *inode); <<<<<<<<
> >+ 
> >+int rcfs_empty(struct dentry *); 
> >+struct inode *rcfs_get_inode(struct super_block *, int, dev_t); 
> 
> You have this as both inline and exported.  The usage implies that it is 
> indeed exported, so inline should not be used in the decl.
> 
> ++doug

Good catch - will fix - thanks!

gerrit
