Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUBFSwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUBFSwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:52:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:19899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265719AbUBFSv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:51:59 -0500
Date: Fri, 6 Feb 2004 10:51:32 -0800
From: Greg KH <greg@kroah.com>
To: "Hefty, Sean" <sean.hefty@intel.com>
Cc: Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040206185132.GG32116@kroah.com>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 08:42:14AM -0800, Hefty, Sean wrote:
> 
> We want to continue to discuss specific details about what's needed to
> add the code into the kernel.  Here's a list of modifications that I
> think are needed so far:
> 
> * Update the code to make direct calls for atomic operations.
> * Verify the use of spinlock calls.

Does this include "remove shim around spinlock calls"?  You should just
call the kernel functions and not try to wrap them.

> * Reformat the code for tab spacing and curly brace usage.
> * Elimination of typedefs.

All of these are great things to start with.

thanks,

greg k-h
