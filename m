Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVFBXGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFBXGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVFBXGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:06:46 -0400
Received: from fmr21.intel.com ([143.183.121.13]:31872 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261548AbVFBXGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:06:32 -0400
Date: Thu, 2 Jun 2005 16:06:04 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, ak@suse.de, nanhai.zou@intel.com,
       rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [discuss] Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050602160603.C14384@unix-os.sc.intel.com>
References: <20050602133256.A14384@unix-os.sc.intel.com> <20050602135013.4cba3ae2.akpm@osdl.org> <20050602151912.B14384@unix-os.sc.intel.com> <20050602154823.15141bfc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050602154823.15141bfc.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 02, 2005 at 03:48:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:48:23PM -0700, Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> > ia64, ppc64 and s390 seems be getting this info from thread_info or 
> > thread_struct in the task struct.
> 
> I know.  I'm claiming that this is conceptually wrong.

I def see your point. But this is too late for 2.6.12.  We want to get this 
fixed in 2.6.12.  We can do the cleanup at a more convenient time.

thanks,
suresh
