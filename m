Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265455AbUFHX2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbUFHX2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUFHX2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:28:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:54148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265455AbUFHX2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:28:13 -0400
Date: Tue, 8 Jun 2004 16:26:38 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
Message-ID: <20040608232638.GC17100@kroah.com>
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com> <40BE6CA9.9030403@zytor.com> <20040603193256.GD23564@kroah.com> <7430000.1086729016@dyn318071bld.beaverton.ibm.com> <10660000.1086732946@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10660000.1086732946@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 03:15:47PM -0700, Hanna Linder wrote:
> > 
> > Here is the patch that uses a cpu hotplug callback, to allow dynamic support 
> > of cpu id for classes in sysfs.
> > 
> > This patch applies on top of the one I sent out earlier that Greg included.
> > I do not have access to hardware that supports cpu hotswapping (virtually or not) 
> > so have not been able to test that aspect of the patch. However, the original
> > functionality of listing static cpu's still works.
> > 
> > Please consider for testing or inclusion. 
> > 
> > Signed-off-by Hanna Linder <hannal@us.ibm.com>
> > 
> > Thanks.
> > 
> > Hanna Linder
> > IBM Linux Technology Center
> 
> Gregkh found a small bug in the error path. Here is the fixed version:

Looks good, I've added it to my trees.

thanks,

greg k-h
