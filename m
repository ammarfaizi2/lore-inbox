Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVKRWlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKRWlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVKRWlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:41:15 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:38080 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932120AbVKRWlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:41:14 -0500
Date: Fri, 18 Nov 2005 17:41:13 -0500
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dvd writes truncated 3 Mbytes
Message-ID: <20051118224113.GJ9488@csclub.uwaterloo.ca>
References: <200511181703.47903.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511181703.47903.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 05:03:47PM -0500, Gene Heskett wrote:
> I've just tried to burn a dvd iso 4 times, 2 different brands of disks,
> getting an identical but bad md5sum for all 4 writes.
> 
> K3B reports it has written 1160 or 1163 Mbytes each time, but doesn't
> seem to have a problem with that.
> 
> Kernel is 2.6.14.2, without packet writing for cd/dvd turned on, but I
> have one with it enabled building now.  K3B is 0.11.13, cdrecord is
> 2.1(dvd), groisofs is 5.21, mkisofs is 2.1-a34.  The drive is a Lite-On
> DVDRW SOHW-1673S.
> 
> Has anyone else encountered a similar problem?  I've been making
> good cd's all along with no problems, in this new drive, till now.

Seems more of an application issue than a kernel issue.

Does it work from the command line (could be a k3b bug after all)?

cdrecord with dvd support (unless prodvd version) is not worth using on
most drives.  growisofs is great for most drives.

The cdwrite mailinst list at lists.debian.org (not debian specific) is
the best place I know to get answers to cd/dvd writing questions.

Len Sorensen
