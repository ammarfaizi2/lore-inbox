Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVBXSXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVBXSXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVBXSXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:23:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2198 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262447AbVBXSVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:21:34 -0500
To: Greg KH <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM [7/8] Resource controller for number of tasks per class 
In-reply-to: Your message of Thu, 24 Feb 2005 10:00:39 PST.
             <20050224180039.GA10569@kroah.com> 
Date: Thu, 24 Feb 2005 10:21:32 -0800
Message-Id: <E1D4NcC-0003ET-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Feb 2005 10:00:39 PST, Greg KH wrote:
> On Thu, Feb 24, 2005 at 01:34:38AM -0800, Gerrit Huizenga wrote:
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <asm/errno.h>
> > +#include <asm/div64.h>
> > +#include <linux/list.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/ckrm_rc.h>
> > +#include <linux/ckrm_tc.h>
> > +#include <linux/ckrm_tsk.h>
> 
> What was that response you gave me about the fact that you fixed up the
> proper ordering of #include files...
 
Doh - missed that one.  :(

Fixed now.

gerrit
