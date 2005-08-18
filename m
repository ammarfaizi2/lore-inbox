Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVHRW62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVHRW62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVHRW62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:58:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24531 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932510AbVHRW61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:58:27 -0400
Date: Fri, 19 Aug 2005 08:58:23 +1000
From: Nathan Scott <nathans@sgi.com>
To: kristina clair <kclair@gmail.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <20050819085823.B4075975@wobbly.melbourne.sgi.com>
References: <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu> <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191746470.7094@chaos.egr.duke.edu> <428D0D1E.9070607@wildbrain.com> <dff3752705081811498984f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <dff3752705081811498984f5@mail.gmail.com>; from kclair@gmail.com on Thu, Aug 18, 2005 at 06:49:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 06:49:05PM +0000, kristina clair wrote:
> I've just come across this oops.  We're running gentoo with a 2.6.11
> kernel, xfs + nfs + lvm (+hardware raid).

Check whether your kernel has this fix included:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4120db47198d21d8cd3b2cdbbe1ea6118a50bcd4

cheers.

-- 
Nathan
