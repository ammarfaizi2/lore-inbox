Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSGSVlh>; Fri, 19 Jul 2002 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSGSVlh>; Fri, 19 Jul 2002 17:41:37 -0400
Received: from brev.stud.ntnu.no ([129.241.56.70]:18907 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S317058AbSGSVlf>; Fri, 19 Jul 2002 17:41:35 -0400
Date: Fri, 19 Jul 2002 23:44:37 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
Message-ID: <20020719214437.GB14331@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20020719192607.GA13880@stud.ntnu.no> <20020719140416.A25577@eng2.beaverton.ibm.com> <3D3883F6.7090608@fabbione.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3883F6.7090608@fabbione.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Massimo Di Nitto:
> I have an HSG80 connected on the other side and I got this problem with
> the beta6 drivers from qlogic.
> The only way I made it working was using the kernel driver shipped with 
> rh7.3
> that has been modified to support the HSG80 (according to the changelog  
> supported
> only by the beta6 series).

I find it odd if it's the driver, to be honest. Cause we've been running
with everything from 4.x-series, 5.x-series and 6.x-series on our current
in-production-system. This also runs linux vanilla, although with qla
driver patched in-kernel. (Currently 2.4.18 running).

So, the only differense between the new and old setup is:
* Dell 2550 in old vs 2650 in new (2xP3 vs 2xP4 Xeon)
* Old servers mount one disk each (and have only one HBA), but
  the new servers are supposed to have two HBAs, and have one
  disk on each HBA.

I don't see any good reason why this should result in no disks found
whatsoever.

-- 
Thomas
