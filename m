Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWEXIck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWEXIck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 04:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWEXIck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 04:32:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39129 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932666AbWEXIcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 04:32:39 -0400
Date: Wed, 24 May 2006 13:58:22 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524082822.GB7743@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060524012412.GB7412499@melbourne.sgi.com> <20060524050214.GB9639@in.ibm.com> <20060524061933.GG7418631@melbourne.sgi.com> <20060524070605.GA7743@in.ibm.com> <20060524081545.GI7418631@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524081545.GI7418631@melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought you were referring to shrink_dcache_parent(). At least, I
> was, and the hunk of diff that your comment followed after was from
> select_parent(). Please correct me if I'm wrong, but I think we're
> agreeing that it's doing the right thing in select_parent().
> 
> The modified shrink_dcache_sb() doesn't do do any list moving at all,
> it simply frees all the dentries on the superblock in a single pass.....

I think I misread the code, I thought I was still at an older
function.

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> R&D Software Enginner
> SGI Australian Software Group

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
