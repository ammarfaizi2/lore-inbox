Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319580AbSIMJ1o>; Fri, 13 Sep 2002 05:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319581AbSIMJ1o>; Fri, 13 Sep 2002 05:27:44 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:2054 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S319580AbSIMJ1n>;
	Fri, 13 Sep 2002 05:27:43 -0400
Message-ID: <3D81B09B.7030405@iinet.net.au>
Date: Fri, 13 Sep 2002 19:32:11 +1000
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Ivanov <ivandi@vamo.orbitel.bg>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS?
References: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Ivanov wrote:
> I think that you missed the main problem with all this new "great"
> filesystems. And the main problem is potential data loss in case of a
> crash. Only ext3 supports ordered or journal data mode.
> 
> XFS and JFS are designed for large multiprocessor machines powered by UPS
> etc., where the risk of power fail, or some kind of tecnical problem is
> veri low.
> 
> On the other side Linux works in much "risky" environment - old
> machines, assembled from "yellow" parts, unstable power suply and so on.
> 
> With XFS every time when power fails while writing to file the entire file
> is lost. The joke is that it is normal according FAQ :)
> JFS has the same problem.
> With ReiserFS this happens sometimes, but much much rarely. May be v4 will
> solve this problem at all.
> 
> The above three filesystems have problems with badblocks too.
> 
> So the main problem is how usable is the filesystem. I mean if a company
> spends a few tousand $ to provide a "low risky" environment, then may be
> it will use AIX or IRIX, but not Linux.
> And if I am running a <$1000 "server" I will never use XFS/JFS.

This just is not the issue. If we only wanted filesystems which behaved 
like ext2/3, we would only have ext2/3. The issue, if you have all 
forgotten, is Linus not providing information on why XFS is a problem to 
be merged. He asked them to make it easy to merge - they have done so. 
Now they ask why the patch is ignored, and are promptly ignored further.


