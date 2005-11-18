Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVKRQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVKRQzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVKRQzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:55:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53738 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964808AbVKRQzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:55:20 -0500
Subject: Re: [RFC] sys_punchhole()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Ragnar =?ISO-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, hugh@veritas.com, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20051118164227.GA14697@vestdata.no>
References: <1131664994.25354.36.camel@localhost.localdomain>
	 <20051110153254.5dde61c5.akpm@osdl.org>
	 <20051113150906.GA2193@spitz.ucw.cz>  <20051118164227.GA14697@vestdata.no>
Content-Type: text/plain; charset=utf-8
Date: Fri, 18 Nov 2005 08:54:53 -0800
Message-Id: <1132332893.24066.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 17:42 +0100, Ragnar Kjørstad wrote:
> On Sun, Nov 13, 2005 at 03:09:06PM +0000, Pavel Machek wrote:
> > > > We discussed this in madvise(REMOVE) thread - to add support 
> > > > for sys_punchhole(fd, offset, len) to complete the functionality
> > > > (in the future).
> > > > 
> > > > http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> > > > 
> > > > What I am wondering is, should I invest time now to do it ?
> > > 
> > > I haven't even heard anyone mention a need for this in the past 1-2 years.
> > 
> > Some database people wanted it maybe month ago. It was replaced by some 
> > madvise hack...
> 
> 
> sys_punchhole is also potentially very useful for Hirarchial Storage
> Management. (Holes are typically used for data that have been migrated
> to tape).

I agree. But I am not interested in adding whole lot of complexity in
the kernel, just because some "potential" use for this. I want to know,
if people/products which really really need this feature and their 
requirements, before I go down that path.

For that matter, HSM folks really care about DMAPI. But I never got
them to explicitly tell me, what is the most minimum subset interfaces
they *absolutely* need (and why) in the whole DMAPI specs :( I always
hear complaints about not having DMAPI.

Thanks,
Badari

