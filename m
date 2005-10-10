Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVJJKmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVJJKmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVJJKmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 06:42:23 -0400
Received: from web30305.mail.mud.yahoo.com ([68.142.200.98]:44695 "HELO
	web30305.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750725AbVJJKmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 06:42:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kypA9dZfVanmcpzl90v1BVp8kkNcbNPxcCrFQVMGBIiQLMp00CFKGYT6meUzSMb+7YSUG5dnqpmMEJPUvzu/J0qZtQkCp5vyyE1GmCCQegZ27Zcfk0+kE0m0vy7NKKk5j82yr21ub2hEoHBg/+gTJH3EOt6QVCXv//sTU0D7qKk=  ;
Message-ID: <20051010104217.20341.qmail@web30305.mail.mud.yahoo.com>
Date: Mon, 10 Oct 2005 03:42:17 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
To: Jon Burgess <jburgess@uklinux.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4346EA35.90700@uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK,

I now dumped RAID5 and am running all of my 12 disks
separately each partitioned with XFS.

I did a very crude test of reading a single 1GB file
from each of my disks in parallel by putting 12 dd
processes into the background. Each file was read at
approximately 35MB/s giving an aggragate of a little
over 400MB/s.   According to 3Ware support, 400MB/s is
the "theoretical maximum" of this controller.  I'm
very happy with these results.

I want to run a killer test where 400 files are being
read in parallel to see what the combined throughput
would be.   Can anyone recommend a benchmark utility
that would help me do so?  I tried using bonnie/iozone
but they (to my limited understanding) won't do this.

Can anyone point me in the right direction?

Thank you


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
