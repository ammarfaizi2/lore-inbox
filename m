Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVD0FIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVD0FIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 01:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVD0FII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 01:08:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51595 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261409AbVD0FIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 01:08:04 -0400
Date: Wed, 27 Apr 2005 10:38:16 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't oops when unregistering unknown kprobes
Message-ID: <20050427050816.GE32766@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050426162203.GE27406@gilgamesh.home.res> <20050426194841.GA2955@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426194841.GA2955@taniwha.stupidest.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,
On Tue, Apr 26, 2005 at 12:48:41PM -0700, Chris Wedgwood wrote:
> On Tue, Apr 26, 2005 at 06:22:03PM +0200, Frederik Deweerdt wrote:
> 
> > Here's a patch that handles gracefully attempts to unregister
> > unregistered kprobes (ie. a warning message instead of an oops).
> > Patch is against 2.6.12-rc3
> 
> Why not -EINVAL instead of the printk?

This problem has been already fixed, pls see the URL below.
http://lkml.org/lkml/2005/4/11/112

Currently this patch is in -mm tree. But this patch does not have the
prink reporting failure.

Thanks
Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
