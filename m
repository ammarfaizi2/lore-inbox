Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSGYQ0g>; Thu, 25 Jul 2002 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSGYQ0g>; Thu, 25 Jul 2002 12:26:36 -0400
Received: from waste.org ([209.173.204.2]:25827 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315337AbSGYQ0f>;
	Thu, 25 Jul 2002 12:26:35 -0400
Date: Thu, 25 Jul 2002 11:29:46 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Header files and the kernel ABI
In-Reply-To: <20020725073221.GP574@clusterfs.com>
Message-ID: <Pine.LNX.4.44.0207251127150.17906-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Andreas Dilger wrote:

> That brings up the question - how do you tie a particular
> <linux/abi/*.h> to a particular kernel?  Should there be a bunch of
> directories <linux/abi-2.4/*.h> and/or <linux/abi-2.4.12/*.h> and/or
> <linux/abi-`uname -r`/*.h> or what?  While there are efforts to keep
> the ABI constant for major stable releases, this is not always true,
> so abi-2.4 will certainly not be enough.  Maybe linux/abi is a symlink
> to the abi directory of currently running kernel?

Ideally, the ABI layer would be maintained and packaged separately from
both the kernel and glibc to avoid gratuitous changes from either side.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

