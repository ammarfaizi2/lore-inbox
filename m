Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291355AbSAaV6D>; Thu, 31 Jan 2002 16:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291352AbSAaV5x>; Thu, 31 Jan 2002 16:57:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13187 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291353AbSAaV5c>;
	Thu, 31 Jan 2002 16:57:32 -0500
Date: Thu, 31 Jan 2002 16:57:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Kris Urquhart <kurquhart@littlefeet-inc.com>
cc: "'Andreas Dilger'" <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ext2/mount - multiple mounts corrupts inodes
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256FA@BUFORD.littlefeet-inc.com>
Message-ID: <Pine.GSO.4.21.0201311651450.17860-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Jan 2002, Kris Urquhart wrote:

> Dec 31 23:42:41 jumptec kernel: VFS: Disk change detected on device
> ide0(3,3)
> Dec 31 23:42:41 jumptec kernel: VFS: Disk change detected on device
> ide0(3,3)
> Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer

I'd say...  Looks like a broken disk change check and everything after
that is not a surprise.

What patches do you have applied and what chipset it is?

