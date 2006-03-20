Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWCTN7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWCTN7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWCTN7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:59:31 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:48301 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964801AbWCTN7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:59:31 -0500
Date: Mon, 20 Mar 2006 19:29:49 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060320135949.GA31074@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320031017.23d8a9b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320031017.23d8a9b1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 03:10:17AM -0800, Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > +/**
> >  + *  This function hooks the readpages() of all modules that have active
> >  + *  probes on them. The original readpages() is called for the given
> >  + *  inode/address_space to actually read the pages into the memory.
> >  + *  Then all probes that are specified on these pages are inserted.
> >  + */
> 
> The "/**" thing is designed to introduce a kerneldoc-style comment, but
> these comments aren't using kerneldoc.

Yes. I will take care of this issue.

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
