Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbULOTpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbULOTpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbULOTpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:45:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:29177 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262463AbULOToT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:44:19 -0500
Date: Wed, 15 Dec 2004 11:21:01 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST 2.6.10-rc2 0/4] module sysfs: module sysfs related clean ups
Message-ID: <20041215192100.GA10060@kroah.com>
References: <20041123061252.GA14209@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123061252.GA14209@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 03:12:52PM +0900, Tejun Heo wrote:
>  Hello, Greg.  Hello, Rusty.
> 
>  I forgot kfree(mk) in params.c:kernel_param_sysfs_setup() on failure
> path.  You can just add kfree(mk) like the following.

Hm, care to regenerate all of the patches, with this fix, and include in
them a description of what they do and a Signed-off-by: line (you forgot
it in one of these.)  That way I can apply them to the tree properly.

thanks,

greg k-h
