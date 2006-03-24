Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWCXPXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWCXPXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWCXPXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:23:05 -0500
Received: from fmr20.intel.com ([134.134.136.19]:30684 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750760AbWCXPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:23:03 -0500
Date: Fri, 24 Mar 2006 07:22:51 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820 table
Message-ID: <20060324072250.A13756@unix-os.sc.intel.com>
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <200603231856.12227.ak@suse.de> <1143140539.3147.44.camel@laptopd505.fenrus.org> <1143141320.3147.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1143141320.3147.47.camel@laptopd505.fenrus.org>; from arjan@linux.intel.com on Thu, Mar 23, 2006 at 11:15:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:15:19AM -0800, Arjan van de Ven wrote:
> 
>    >
>    > I'll do a new patch using this for x86_64 though, no need to make a
>    > second function like this.
> 
>     int  __init  e820_mapped(unsigned  long  start,  unsigned  long  end,
>    unsigned type)


Why not use the same type of function like x86_64 as well instead of the newly
added is_820_mapped()? If the purpose of both functions is the same, i386 could benefit 
with same style code instead of a slight variant.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
