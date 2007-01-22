Return-Path: <linux-kernel-owner+w=401wt.eu-S1750860AbXAVGTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXAVGTS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 01:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbXAVGTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 01:19:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58352 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750788AbXAVGTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 01:19:17 -0500
Date: Mon, 22 Jan 2007 17:18:52 +1100
From: David Chinner <dgc@sgi.com>
To: Stefan Priebe - FH <studium@profihost.com>
Cc: linux-kernel@vger.kernel.org, stefan@priebe.ws
Subject: Re: XFS or Kernel Problem / Bug
Message-ID: <20070122061852.GT33919298@melbourne.sgi.com>
References: <20060801142755.C2326184@wobbly.melbourne.sgi.com> <44CED8F4.9080208@profihost.com> <20060801143212.D2326184@wobbly.melbourne.sgi.com> <44CEDA1D.5060607@profihost.com> <20060801143803.E2326184@wobbly.melbourne.sgi.com> <44CF36FB.6070606@profihost.com> <20060802090915.C2344877@wobbly.melbourne.sgi.com> <44D07AB7.3020409@profihost.com> <20060802201805.A2360409@wobbly.melbourne.sgi.com> <45B35CD7.4080801@profihost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B35CD7.4080801@profihost.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 01:30:15PM +0100, Stefan Priebe - FH wrote:
> Hello!
> 
> I've 3 Servers which works wonderful with 2.6.16.X (also testet the
> latest 2.6.16.37)
> 
> but with 2.6.18.6 i get these errors:

[ EIP is at xfs_bmap_add_extent_hole_delay+0x58d/0x59b ]
[ EIP is at generic_file_buffered_write+0x390/0x6cf ]

Do you have a reproducable test case for these? if not,
do you have any idea what is going on in the system at the time
of the failure?

Can you describe the storage subsystem you are using and post the
output of xfs_growfs -n <mntpt> on the filesystem that is causing
problems?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
