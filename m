Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUEGUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUEGUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUEGUVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:21:07 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:10762 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263756AbUEGUOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:14:01 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Date: Fri, 7 May 2004 13:13:43 -0700
User-Agent: KMail/1.6.1
Cc: greg@kroah.com
References: <20040317213714.GD23195@localhost> <20040319175957.GB10432@kroah.com> <200403191053.38131.jbarnes@sgi.com>
In-Reply-To: <200403191053.38131.jbarnes@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405071313.43493.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 19, 2004 10:53 am, Jesse Barnes wrote:
> Here's the (very platform specific) patch I did for Altix, just to see
> what it would look like, and to solicit comments.  There's some other
> per-node stuff that would be nice to have available to userspace too,
> mostly for administrative purposes, like the chipset revision and
> type, firmware revision, and other hardware specific details.  One way
> to export that sort of thing is with some sort of arbitrary data blob,
> but like you said, that violates the sysfs one file, one value
> principle.

Greg, any comments on this?  (Sorry I was gone for much of last month and lost 
track of this thread.)  Maybe a whole subdirectory containing physical tag, 
version files and such would make more sense?

Jesse
