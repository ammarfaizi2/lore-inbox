Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVATWsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVATWsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVATWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:48:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2739 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262203AbVATWsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:48:16 -0500
Date: Thu, 20 Jan 2005 16:48:12 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: anton@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: EEH Recovery
Message-ID: <20050120224812.GK9140@austin.ibm.com>
References: <20050106192413.GK22274@austin.ibm.com> <20050117201415.GA11505@austin.ibm.com> <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 05:06:05PM +1100, Paul Mackerras was heard to remark:
> Linas Vepstas writes:
> 
> > p.s.  It was not clear to me if the EEH patch previously sent 
> > (6 January 2005, same subject line) will be wending its way into 
> > the main Torvalds kernel tree, or not.  I hadn't really gotten
> > confirmation one way or another.
> 
> I'm not really totally happy with it yet, on a number of fronts:

[...]

I forgot to mention: while I agree with some/many of these points,
especially with regards to recovery, I'd also like to note that the 
patch was mailed in two independent parts:  

-- a number of generic infrastructure routines, all in a ppc64 patch, and
-- the code that actually performs the recovery, as a patch to 
   the drivers/pci/hotplug subsystem.

While the actual recovery code is controversial (e.g. no support of 
scsi recovery), I'd like to at least get in the the generic 
infrastructure pieces.  

--linas
