Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264496AbUEMTrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbUEMTrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUEMTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:45:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:15824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264729AbUEMTmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:42:53 -0400
Date: Thu, 13 May 2004 12:42:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-ID: <20040513124249.J21045@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040513123809.01398f93.akpm@osdl.org>; from akpm@osdl.org on Thu, May 13, 2004 at 12:38:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > 
> >  +static int capability_mask;
> >  +module_param_named(mask, capability_mask, int, 0);
> >  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> 
> Is there a way to make this tunable at runtime, btw?

Yeah, it'd require sysctl or similar, and further reduces the security,
unless you only allow bit clearing or something.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
