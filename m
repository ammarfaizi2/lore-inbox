Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293047AbSCAWcN>; Fri, 1 Mar 2002 17:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293167AbSCAWcE>; Fri, 1 Mar 2002 17:32:04 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:55764 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293111AbSCAWcB>; Fri, 1 Mar 2002 17:32:01 -0500
Date: Fri, 1 Mar 2002 16:31:57 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Thomas Schenk <tschenk@origin.ea.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Recommendations on Gigabit Ethernet Cards
Message-ID: <20020301163157.B14210@asooo.flowerfire.com>
In-Reply-To: <1015011671.23135.27.camel@bagend.origin.ea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1015011671.23135.27.camel@bagend.origin.ea.com>; from tschenk@origin.ea.com on Fri, Mar 01, 2002 at 01:41:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had good luck with the Intel e1000 on copper and the SysKonnect
SK-98xx on fiber, attached to Cisco and Foundry hardware.  No problems
and good performance so far.  We're running SysKonnects on GigE IDS
boxes, so they've been taking a pounding.

I've been grabbing the e1000 driver from Intel's site, and I'm using the
in-kernel SysKonnect driver with a patch to enable the Dual-NIC model.

-- 
Ken.
brownfld@irridia.com

On Fri, Mar 01, 2002 at 01:41:09PM -0600, Thomas Schenk wrote:
| I am looking for recommendations on which of the gigabit ethernet cards
| supported by the 2.4.x (x >= 17) kernel I should use.  Any guidance
| based on personal experience would be greatly appreciated.  I am looking
| for recommendation based on performance and stability of the driver.
| 
| Tom S.
| 
| -- 
|   
| +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
|    | Tom Schenk            | A positive attitude may not solve all your 
| |
|    | Online Ops, EA.COM    | problems, but it will annoy enough people
| to  |
|    | tschenk@origin.ea.com | make it worth the effort. -- Herm Albright 
| |
|   
| +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
