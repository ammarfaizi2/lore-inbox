Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbTCRQTc>; Tue, 18 Mar 2003 11:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbTCRQTc>; Tue, 18 Mar 2003 11:19:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30861 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262531AbTCRQTa>; Tue, 18 Mar 2003 11:19:30 -0500
Date: Tue, 18 Mar 2003 08:30:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, colpatch@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] NUMAQ subarchification
Message-ID: <20560000.1048005011@[10.10.2.4]>
In-Reply-To: <1048004181.2210.53.camel@mulgrave>
References: <1047676332.5409.374.camel@mulgrave><3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com><247240000.1047693951@flay>  <3E767D45.6020308@us.ibm.com> <1048004181.2210.53.camel@mulgrave>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All in all, properly done, there would be very little code duplication
> even for something as PC like as the summit.
> 
> If I read correctly between the whines, the real issue is that subarch
> is used to support things that vary from uniquely oddball to extremely
> weird and are all ancient and highly unlikely ever to be found in
> nature.  IBM, understandably, doesn't want its brand new and expensive
> summit lumped with such company.

The company argument really doesn't bother me at all ;-)
I'm much more concerned with making things easy to maintain ... the .h
file stuff under subarch is *superb* as long as you don't have to build
one kernel that supports many machines. If the .c stuff worked like that,
I'd have no issues.

The function vector stuff is another issue ... we need to make the distros
happy at some point soon for the mainline arches that need to be supported
at least (ie NUMA-Q et al don't matter so much).

M.

