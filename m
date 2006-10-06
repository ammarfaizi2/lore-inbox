Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWJFANB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWJFANB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWJFANB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:13:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932481AbWJFANA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:13:00 -0400
Date: Thu, 5 Oct 2006 17:12:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: kmannth@us.ibm.com, Andi Kleen <ak@suse.de>, mel gorman <mel@csn.ul.ie>,
       Vivek goyal <vgoyal@in.ibm.com>, Steve Fox <drfickle@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64 II
Message-Id: <20061005171223.9e8fda85.akpm@osdl.org>
In-Reply-To: <45259D2E.3000002@us.ibm.com>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<200610060114.03466.ak@suse.de>
	<1160091179.5664.17.camel@keithlap>
	<200610060135.56134.ak@suse.de>
	<1160092711.5664.19.camel@keithlap>
	<45259D2E.3000002@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 17:02:54 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> > Code: 0f 0b 48 8b 3d 15 ab 1e 00 be d0 00 00 00 e8 c0 f5 ff ff 48
> > RIP  [<ffffffff8027f8fa>] init_list+0x1d/0xfd
> >  RSP <ffffffff80577f48>
> >  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> >
> >
> > I am going to revert the patch and see if it works.  I ran -git22 just
> > fine. 
> >
> > Thanks,
> >   Keith 
> >
> >   
> Keith,
> 
> I fixed this already. Can you look for it on lkml (look for 2.6.18-mm3 
> in the subject line).
> one typo in mm/slab.c

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/hot-fixes
