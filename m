Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264400AbRF1VMN>; Thu, 28 Jun 2001 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbRF1VME>; Thu, 28 Jun 2001 17:12:04 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:3090 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264400AbRF1VLv>; Thu, 28 Jun 2001 17:11:51 -0400
X-Apparently-From: <slamaya@yahoo.com>
Message-ID: <3B3B9DD2.1030103@yahoo.com>
Date: Fri, 29 Jun 2001 00:12:50 +0300
From: Yaacov Akiba Slama <slamaya@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010625
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 From what I understand from Linus's mail to lkml, there is a difference 
between JFS and XFS:
JFS doesn't require any modifications to existing code, its only an 
addition.
XFS on the contrary is far more intrusive.
So it seems that even if JFS is less complete than XFS (no ACL, quotas 
for instance), and even if it is less robust (I don't know if it is, I 
only used so far XFS and ext3 -with success), its inclusion in current 
kernel is a lot easier and I don't see any (technical) reason for not 
including it.
I don't think ext3 will have difficulties to be included in the kernel 
because a) the guys working on it are lk veterans and b) Redhat (VA 
also) is already including it in its kernels (rawhide AND 7.1 update).
So I only hope that the smart guys at SGI find a way to prepare the 
patches the way Linus loves because now the file 
"patch-2.4.5-xfs-1.0.1-core" (which contains the modifs to the kernel 
and not the new files) is about 174090 bytes which is a lot.

YA


*Kervin Pierre* (/ kpierre@fit.edu/ <mailto:kpierre@fit.edu> ) wrote :

Hello,

Question.

Are there plans to include JFS and XFS in the kernel?

Both those projects have been declared stable by their development
teams, and I'm guessing they can now be included as experimental, just
as reiser has been.

Just curious,
-Kervin

Steve Best wrote:
/> /
/> June 28, 2001:/
/> /
/> IBM is pleased to announce the v 1.0.0 release of the open source/
/> Journaled File System (JFS), a high-performance, and scalable file/
/> system for Linux./
/> /
/> http://oss.software.ibm.com/jfs /
/> /
/> JFS is widely recognized as an industry-leading high-performance file/
/> system, providing rapid recovery from a system power outage or crash/
/> and the ability to support extremely large disk configurations. The/
/> open source JFS is based on proven journaled file system technology/
/> that is available in a variety of operating systems such as AIX and/
/> OS/2./
/> /
/> JFS was open sourced under the GNU General Public License with release/
/> v 0.0.1 on February 2. 2000 and has matured with help and support of the/
/> open source community and its "Enterprise ready" release today is due/
/> to joint work between the JFS team and the community. Following the/
/> development style of "Release Early, Release Often" the JFS open source/
/> project has seen 37 interim releases as part of the process./
/> /
/> The open source JFS for Linux v 1.0.0 is released for the Linux 2.4.x/
/> kernel and offers the following advanced features:/
/> /
/> * Fast recovery after a system crash or power outage/
/> /
/> * Journaling for file system integrity/
/> /
/> * Journaling of meta-data only/
/> /
/> * Extent-based allocation/
/> /
/> * Excellent overall performance/
/> /
/> * 64 bit file system/
/> /
/> * Built to scale. In memory and on-disk data structures are designed to/
/> scale beyond practical limit/
/> /
/> * Designed to operate on SMP hardware and also a great file system for/
/> your workstation/
/> /
/> * Completely free of prerequisite kernel changes (easy integration path/
/> into the kernel source tree)/
/> /
/> * Detailed Howto for creating a system with JFS as the /boot and /root/
/> file system using lilo/
/> /
/> * Complete set of file system utilities/
/> /
/> * On-disk compatibility with OS/2 JFS file systems/
/> /
/> The JFS Team (Barry Arndt, Steve Best, Dave Kleikamp)/
/> /
/> -/
/> To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in/
/> the body of a message to majordomo@vger.kernel.org/
/> More majordomo info at http://vger.kernel.org/majordomo-info.html /
/> Please read the FAQ at http://www.tux.org/lkml/ /
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/
------------------------------------------------------------------------


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

