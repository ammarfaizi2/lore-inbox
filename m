Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUDOLtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDOLtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 07:49:04 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:10246 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262528AbUDOLtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 07:49:02 -0400
Date: Thu, 15 Apr 2004 06:48:17 -0500
From: Robin Holt <holt@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-ID: <20040415114817.GB20441@lnx-holt.americas.sgi.com>
References: <1081373058.9061.16.camel@arrakis> <20040407232712.2595ac16.ak@suse.de> <1081989517.1206.206.camel@arrakis> <20040415123915.016523df.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415123915.016523df.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 12:39:15PM +0200, Andi Kleen wrote:
> On Wed, 14 Apr 2004 17:38:37 -0700
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> > 2) Rename check_* to mpol_check_*
> 
> I really don't understand why you insist on renaming all my functions? 
> I like the current naming, thank you.
> 

I like the mpol_ flavors because there is no namespace collision
on these.  When I look at cscope or any other code analysis tool,
I know that the mpol_... functions belong together.  Makes
investigating other people's code easier.

Just my 2 cents,
Robin Holt
