Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282815AbRLORJp>; Sat, 15 Dec 2001 12:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282821AbRLORJh>; Sat, 15 Dec 2001 12:09:37 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:19727 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S282815AbRLORJZ>; Sat, 15 Dec 2001 12:09:25 -0500
Message-ID: <3C1B8371.7050008@namesys.com>
Date: Sat, 15 Dec 2001 20:08:01 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
        Nikita Danilov <god@namesys.com>, green@thebsh.namesys.com
Subject: Re: [reiserfs-dev] fsx for Linux showing up reiserfs problem?
In-Reply-To: <20011215154029.A3954@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>Hi folks,
> After reading the article at http://www.kerneltrap.com/article.php?sid=415&mode=thread&order=0
>on the FreeBSD guys finding a bunch of NFS bugs with a stress tool,
>I took a look at fsx and played with it a little under Linux..
>
>The changes to make it work are trivial, and are at
>http://www.codemonkey.org.uk/cruft/fsx-linux.c
>(non-existant include & expected mmap() behaviour differences)
>
>I've done a few tests on local filesystems, and so far Ext2 & Ext3
>seem to be holding up..
>
>Reiserfs however dies very early into the test..
>
>  truncating to largest ever: 0x3f15f
>  READ BAD DATA: offset = 0x1d3d4, size = 0x962f
>  OFFSET  GOOD    BAD     RANGE
>  0x1d3d4 0x177d  0x0000  0x  563
>  operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
>
>Options used were ./fsx -c1234 /mnt/test/testfile
>(Although it seems to crash with any -c option)
>
>Looks like an interesting tool, and probably something that should
>be added to testsuites like Cerberus.
>
>regards,
>Dave.
>
Thanks Dave, Elena and Nikita and Green, take a look at this.

Hans


