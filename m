Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUDOSfw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUDOSf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:35:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:47777 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263130AbUDOSdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:33:52 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Robin Holt <holt@sgi.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040415114817.GB20441@lnx-holt.americas.sgi.com>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081989517.1206.206.camel@arrakis>
	 <20040415123915.016523df.ak@suse.de>
	 <20040415114817.GB20441@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1082053977.3111.1.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Apr 2004 11:32:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 04:48, Robin Holt wrote:
> On Thu, Apr 15, 2004 at 12:39:15PM +0200, Andi Kleen wrote:
> > On Wed, 14 Apr 2004 17:38:37 -0700
> > Matthew Dobson <colpatch@us.ibm.com> wrote:
> > > 2) Rename check_* to mpol_check_*
> > 
> > I really don't understand why you insist on renaming all my functions? 
> > I like the current naming, thank you.
> > 
> 
> I like the mpol_ flavors because there is no namespace collision
> on these.  When I look at cscope or any other code analysis tool,
> I know that the mpol_... functions belong together.  Makes
> investigating other people's code easier.
> 
> Just my 2 cents,
> Robin Holt

That was my motivation.  It's not particularly important, especially
since the functions are all declared static.  I just thought they were a
little more readable when prefixed by mpol_.

-Matt

