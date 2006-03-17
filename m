Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWCQAqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWCQAqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbWCQAqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:46:09 -0500
Received: from out-mta11.ai270.net ([83.244.130.121]:63716 "EHLO
	out-mta10.ai270.net") by vger.kernel.org with ESMTP
	id S1751385AbWCQAqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:46:08 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Phillip Lougher <phillip@lougher.org.uk>
Subject: [ANN] Squashfs 3.0 released
Date: Fri, 17 Mar 2006 00:45:42 +0000
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Squashfs 3.0 has finally been released.  Squashfs 3.0 is a major  
improvement to Squashfs, and it addresses most of the issues that  
that have been raised, particularly the 4GB filesystem and file  
limit.  It can be obtained from the usual address http:// 
squashfs.sourceforge.net.  There is still some work to be done, in  
particular NFS support which I'll add as soon as I get time.  After  
this I'll consider resubmitting patches to the LKML.

 From the changelog, the improvements are as follows:

         1. Filesystems are no longer limited to 4 GB.  In
            theory 2^64 or 4 exabytes is now supported.

         2. Files are no longer limited to 4 GB.  In theory the maximum
            file size is 4 exabytes.

         3. Metadata (inode table and directory tables) are no longer
            restricted to 16 Mbytes.

         4. Hardlinks are now suppported.

         5. Nlink counts are now supported.

         6. Readdir now returns '.' and '..' entries.

         7. Special support for files larger than 256 MB has been  
added to
            the Squashfs kernel code for faster read access.

         8. Inode numbers are now stored within the inode rather than  
being
            computed from inode location on disk (this is not so much an
            improvement, but a change forced by the previously listed
            improvements).

Phillip Lougher

