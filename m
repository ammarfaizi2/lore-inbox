Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSCCOAZ>; Sun, 3 Mar 2002 09:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSCCOAG>; Sun, 3 Mar 2002 09:00:06 -0500
Received: from ns.caldera.de ([212.34.180.1]:37795 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284180AbSCCN74>;
	Sun, 3 Mar 2002 08:59:56 -0500
Date: Sun, 3 Mar 2002 14:59:40 +0100
Message-Id: <200203031359.g23Dxdl29135@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: scott1021@attbi.com ("Scott M. Hoffman")
Cc: linux-kernel@vger.kernel.org, <shaggy@austin.ibm.com>
Subject: Re: JFS on 2.4.19-pre2-ac1/2
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.42.0203022041080.1308-100000@nic-118-c60-41.mediaone.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.42.0203022041080.1308-100000@nic-118-c60-41.mediaone.net> you wrote:
> Hi,
>   Under pre2-ac1, untarring my /home backup to JFS had problems.  I was 
> unable to switch virtual consoles for several seconds at a time.  Under 
> ext3 the same kernel was fine.  The output of vmstat shows many more 
> context switches for JFS than ext3, if that means anything.  If anyone's 
> interested in any more info, please ask.
>   Neither kernel produces any info under /proc/fs/jfs as per the config 
> option CONFIG_JFS_STATISTICS.

Could you please boot your kernel with profile=2 and send me the output
of readprofile(1)?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
