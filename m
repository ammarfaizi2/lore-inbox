Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbRILHuV>; Wed, 12 Sep 2001 03:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272692AbRILHuL>; Wed, 12 Sep 2001 03:50:11 -0400
Received: from pat.uio.no ([129.240.130.16]:20966 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S272682AbRILHuC>;
	Wed, 12 Sep 2001 03:50:02 -0400
MIME-Version: 1.0
Message-ID: <15263.5043.111878.128803@charged.uio.no>
Date: Wed, 12 Sep 2001 09:50:11 +0200
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: "'nfs-request@lists.sourceforge.net'" 
	<nfs-request@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: RE: Questions on NFS client inode management.
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC5A3@elway.lss.emc.com>
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC5A3@elway.lss.emc.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == xiangping chen <chen> writes:

     > Hi, Trond Thanks for the reply. What kind of reclaiming scheme
     > is used by NFS client and the Linux local file system, say
     > ext2/ext3? Is it used for reclaiming the inode resources, or
     > for memory in general (like killing processes)?

I'm not really much of an expert on the memory management. I try to
stick to doing NFS. If you are interested in the exact mechanisms of
page reclaiming, you might want to try to study the function
try_to_free_pages() in mm/vmscan.c. It never stops changing though ;-)


     > Is there any benchmark available to test how many active inodes
     > a particular system can support?

Not to my knowledge, but as I say, I'm not really an expert...

Cheers,
   Trond
