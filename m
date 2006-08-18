Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWHRL3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWHRL3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWHRL3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:29:38 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:33003 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964869AbWHRL3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:29:37 -0400
Subject: Re: [patch 0/5] -fstack-protector feature for the kernel (try 2)
From: Arjan van de Ven <arjan@linux.intel.com>
To: akpm@Osdl.org
Cc: linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <200608181315.35536.ak@suse.de>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
	 <200608181315.35536.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 13:29:21 +0200
Message-Id: <1155900561.4494.145.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 13:15 +0200, Andi Kleen wrote:
> On Wednesday 16 August 2006 18:48, Arjan van de Ven wrote:
> > This patch series adds support for the gcc -fstack-protector feature to
> > the kernel. While gcc 4.1 supports this feature for userspace, the patches
> > to support it for the kernel only got added to the gcc tree on 27/7/2006
> > (eg for 4.2); it is expected that several distributors will backport this
> > patch to their 4.1 gcc versions. (For those who want to know more, see gcc
> > PR 28281)
> 
> FWIW -- my queue for 2.6.19 is already quite full and I'm
> in the stabilization phase for the merge.


Andrew, can you please consider sticking these into -mm ?
FC6 already has a gcc capable of using this feature (and I hope/assume
other similar distros as well; for other distros using gcc 4.1, the
respective gcc owner should put in
http://www.fenrus.org/stackprotector/gcc41.patch to fix PR28281) and
since it's a relatively simple feature patch wise (and entirely off if
the config option is off) I sort of feel 2.6.20 is a long way away..


