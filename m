Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVFCPso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVFCPso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFCPso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:48:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:10438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261339AbVFCPsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:48:40 -0400
Date: Fri, 3 Jun 2005 17:48:39 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, ak@suse.de, nanhai.zou@intel.com,
       rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [discuss] Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050603154839.GN23831@wotan.suse.de>
References: <20050602133256.A14384@unix-os.sc.intel.com> <20050602135013.4cba3ae2.akpm@osdl.org> <20050602151912.B14384@unix-os.sc.intel.com> <20050602154823.15141bfc.akpm@osdl.org> <20050602160603.C14384@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602160603.C14384@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 04:06:04PM -0700, Siddha, Suresh B wrote:
> On Thu, Jun 02, 2005 at 03:48:23PM -0700, Andrew Morton wrote:
> > "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> > > ia64, ppc64 and s390 seems be getting this info from thread_info or 
> > > thread_struct in the task struct.
> > 
> > I know.  I'm claiming that this is conceptually wrong.
> 
> I def see your point. But this is too late for 2.6.12.  We want to get this 
> fixed in 2.6.12.  We can do the cleanup at a more convenient time.

My feeling is that all of this is more for post 2.6.12. I still
have not seen anything important that would get fixed by it.

-Andi
