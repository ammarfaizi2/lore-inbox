Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132560AbRCZTHN>; Mon, 26 Mar 2001 14:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRCZTHE>; Mon, 26 Mar 2001 14:07:04 -0500
Received: from laird.ocp.internap.com ([64.94.114.35]:10278 "EHLO
	laird.ocp.internap.com") by vger.kernel.org with ESMTP
	id <S132552AbRCZTG7>; Mon, 26 Mar 2001 14:06:59 -0500
Date: Mon, 26 Mar 2001 11:05:37 -0800 (PST)
From: Scott Laird <laird@internap.com>
X-X-Sender: <laird@laird.ocp.internap.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Andreas Dilger <adilger@turbolinux.com>, LA Walsh <law@sgi.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.33.0103261059300.25866-100000@laird.ocp.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Mar 2001, Matthew Wilcox wrote:
>
> people who can afford 2TB of disc can afford to buy a 64-bit processor.
>

Sort of.  A back-of-the-envelope calculation shows that 2 TB is only 25
80GB IDE drives.  Given 4 3ware 8-channel IDE controllers and a large
enough case, you could probably build a cheap 2TB RAID0 array for ~$10k.
You could do RAID5 for only slightly more.

While this isn't exactly a standard, off-the-shelf, general-purpose sort
of configuration, it definately has its uses.  Be careful assuming that
huge amounts of disk storage requires a huge amount of money, or a high
level of reliability or performance.


Scott

