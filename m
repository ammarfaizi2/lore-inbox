Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752512AbWCQBaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbWCQBaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbWCQBaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:30:24 -0500
Received: from out-mta2.ai270.net ([83.244.130.113]:13270 "EHLO
	out-mta1.ai270.net") by vger.kernel.org with ESMTP id S1752512AbWCQBaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:30:23 -0500
In-Reply-To: <20060317010529.GB30801@schatzie.adilger.int>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317010529.GB30801@schatzie.adilger.int>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CF2CC9AC-3695-45C1-9FA6-9BDAAA6418DD@lougher.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Phillip Lougher <phillip@lougher.org.uk>
Subject: Re: [ANN] Squashfs 3.0 released
Date: Fri, 17 Mar 2006 01:30:03 +0000
To: Andreas Dilger <adilger@clusterfs.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2006, at 01:05, Andreas Dilger wrote:

> On Mar 17, 2006  00:45 +0000, Phillip Lougher wrote:
>> Squashfs 3.0 has finally been released.  Squashfs 3.0 is a major
>> improvement to Squashfs, and it addresses most of the issues that
>> that have been raised, particularly the 4GB filesystem and file
>> limit.
>
> Sometimes it is useful for the casual reader if you include a brief
> blurb about what exactly squashfs is... :-)
>
Ok, for those who are interested, old blurb  from the README follows:

"Squashfs is a highly compressed read-only filesystem for Linux.
It uses zlib compression to compress both files, inodes and directories.
Inodes in the system are very small and all blocks are packed to  
minimise
data overhead. Block sizes greater than 4K are supported up to a maximum
of 64K.

Squashfs is intended for general read-only filesystem use, for archival
use (i.e. in cases where a .tar.gz file may be used), and in constrained
block device/memory systems (e.g. embedded systems) where low  
overhead is
needed."

At the moment it tends to be used for embedded systems, and liveCDs.

Phillip

