Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbULPWdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbULPWdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbULPWdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:33:50 -0500
Received: from roadrunner-base.egenera.com ([63.160.166.46]:3771 "EHLO
	coyote.egenera.com") by vger.kernel.org with ESMTP id S262041AbULPWbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:31:09 -0500
Date: Thu, 16 Dec 2004 17:04:34 -0500
From: Philip R Auld <pauld@egenera.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       alan@lxorguk.ukuu.org.uk, riel@redhat.com, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041216220434.GC16621@vienna.egenera.com>
References: <20041216102652.6a5104d2.akpm@osdl.org> <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Thu, Dec 16, 2004 at 09:00:52PM +0000 Ian Pratt said:
>  
> I think we'd then have to make a decision as to whether merging
> i386 and xen/i386 is feasible. Further, we'd have to make a
> decision as to whether what is really wanted is a single kernel
> that's able to boot-time switch between native i386 and xen,
> rather than just having a single source base. The two options
> would probably result in rather different implementations.
> 

The boot-time switch seems to be the ideal. This would allow 
enterprise Linux vendors to support using Xen w/o having to
deal with a whole archicture release (including install kernel 
etc.). One of the (really strong IMO) arguments for full 
virtualization methods is beinag able to run stock OSes. 
At least for Linux guests, a Xen merge with the boot-time 
option would remove that argument. 

Of course, the resultant kernel changes would need to have no 
measurable impact on native i386... and be possible...


Cheers,

Phil
