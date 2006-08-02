Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWHBFZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWHBFZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHBFZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:25:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21398 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751198AbWHBFZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:25:14 -0400
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Xen-devel] Re: [PATCH 8 of 13] Add a bootparameter to reserve high linear address space for hypervisors
Date: Wed, 2 Aug 2006 07:24:23 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       virtualization@lists.osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <0adfc39039c79e4f4121.1154462446@ezr> <200608020636.58133.ak@suse.de> <1154496058.2570.57.camel@localhost.localdomain>
In-Reply-To: <1154496058.2570.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020724.23583.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 07:20, Rusty Russell wrote:
> On Wed, 2006-08-02 at 06:36 +0200, Andi Kleen wrote:
> > Please just make a proper patch - either add a call to it to all setup_archs,
> > or add a call to before setup_arch in init/main.c. While such ifdefs
> > for specific architecture hacks are more popular lately it doesn't mean they are a good idea.
> 
> It's been around for two years, but if you fix x86_64 to use
> early_param(), and I'll patch the other setup_archs to call
> parse_early_param and remove the init/main.c call 8)

Ok. I will do x86-64.

I can also merge the i386 patch (which is really independent from
the paravirt patchkit) 

-Andi
