Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbRLaPLM>; Mon, 31 Dec 2001 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287536AbRLaPLC>; Mon, 31 Dec 2001 10:11:02 -0500
Received: from wg.pu.ru ([193.124.85.219]:62732 "EHLO wg.pu.ru")
	by vger.kernel.org with ESMTP id <S287532AbRLaPKz>;
	Mon, 31 Dec 2001 10:10:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Vitaly Lipatov <LAV@VL3143.spb.edu>
Organization: LAVNet
To: Bryce Nesbitt <bryce@obviously.com>
Subject: Re: Why would a valid DVD show zero files on Linux?
Date: Mon, 31 Dec 2001 18:10:58 +0300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16L2G8-00050T-00@the-village.bc.nu> <3C307464.2253E26@obviously.com>
In-Reply-To: <3C307464.2253E26@obviously.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011231151059.404B34394E@VL3143.spb.edu>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 December 2001 17:21, Bryce Nesbitt wrote:
> A disk with a blank iso9660 plus a full UDF ought to automatically mount
> UDF, no? How hard would that be to detect?
You have to set type 'auto' in fstab and add 'udf' in first line of 
/etc/filesystems.

Follow is piece of man mount:
              The type iso9660 is the default.  If no  -t  option
              is  given,  or  if  the auto type is specified, the
              superblock  is  probed  for  the  filesystem   type
              (minix, ext, ext2, ext3, xiafs, iso9660, jfs, reis-
              erfs, romfs, ufs, ntfs,  qnx4,  bfs,  xfs,  cramfs,
              hfs,  hpfs,  adfs,  vxfs  are  supported).  If this
              probe fails,  mount  will  try  to  read  the  file
              /etc/filesystems,  or,  if  that  does  not  exist,
              /proc/filesystems.  All  of  the  filesystem  types
              listed  there  will be tried, except for those that
              are labeled "nodev" (e.g., devpts, proc and nfs).

Please tell me is you successfully done it.
On my system it do not work. :(
-- 
Lav
Vitaly Lipatov
GNU! Linux! LaTeX! LyX!
