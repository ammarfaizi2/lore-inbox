Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752587AbWCQKlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbWCQKlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbWCQKlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:41:04 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:18624 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1752584AbWCQKlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:41:01 -0500
Date: Fri, 17 Mar 2006 11:40:23 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060317104023.GA28927@wohnheim.fh-wedel.de>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 March 2006 00:45:42 +0000, Phillip Lougher wrote:
> 
> Squashfs 3.0 has finally been released.  Squashfs 3.0 is a major  
> improvement to Squashfs, and it addresses most of the issues that  
> that have been raised, particularly the 4GB filesystem and file  
> limit.  It can be obtained from the usual address http:// 
> squashfs.sourceforge.net.  There is still some work to be done, in  
> particular NFS support which I'll add as soon as I get time.  After  
> this I'll consider resubmitting patches to the LKML.
> 
> From the changelog, the improvements are as follows:
> 
>         1. Filesystems are no longer limited to 4 GB.  In
>            theory 2^64 or 4 exabytes is now supported.
> 
>         2. Files are no longer limited to 4 GB.  In theory the maximum
>            file size is 4 exabytes.
> 
>         3. Metadata (inode table and directory tables) are no longer
>            restricted to 16 Mbytes.
> 
>         4. Hardlinks are now suppported.
> 
>         5. Nlink counts are now supported.
> 
>         6. Readdir now returns '.' and '..' entries.
> 
>         7. Special support for files larger than 256 MB has been  
> added to
>            the Squashfs kernel code for faster read access.
> 
>         8. Inode numbers are now stored within the inode rather than  
> being
>            computed from inode location on disk (this is not so much an
>            improvement, but a change forced by the previously listed
>            improvements).

Nice list of improvements.  The one still painfully missing is a
fixed-endianness disk format.  Would have been a good time to make an
incompatible change and decide on one or the other.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
