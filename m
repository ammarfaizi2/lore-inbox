Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWJQMSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWJQMSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWJQMSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:18:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36622 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750781AbWJQMSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:18:40 -0400
Date: Tue, 17 Oct 2006 14:18:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, Steve Fox <drfickle@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Badari Pulavarty <pbadari@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>, Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-ID: <20061017121836.GI30596@stusta.de>
References: <200610052250.55146.ak@suse.de> <1160101394.29690.48.camel@flooterbu> <20061006143312.GB9881@skynet.ie> <20061006153629.GA19756@in.ibm.com> <20061006171105.GC9881@skynet.ie> <1160157830.29690.66.camel@flooterbu> <20061006200436.GG19756@in.ibm.com> <Pine.LNX.4.64.0610091049390.30765@skynet.skynet.ie> <20061016181613.GA30090@in.ibm.com> <20061016165814.13b99e5e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016165814.13b99e5e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:58:14PM -0700, Andrew Morton wrote:
> On Mon, 16 Oct 2006 14:16:13 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > 
> > Can you please have a look at the attached patch
> 
> Looks like a fine patch to me, although it could benefit from a comment
> explaining why all those PAGE_ALIGN()s are in there.
> 
> > and include it in -mm.
> 
> Does it fix a patch in -mm or is it needed in mainline?

The bug in my list was reported to be present in mainline [1].

cu
Adrian

[1] http://lkml.org/lkml/2006/10/4/394

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

