Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUJAV4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUJAV4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUJAVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:54:07 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:21235 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S266839AbUJAVwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:52:44 -0400
Subject: Re: md hangs while rebuilding
From: "Shesha B. " Sreenivasamurthy <shesha@inostor.com>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-mm@kvack.org, LinuxKernel Group <linux-kernel@vger.kernel.org>,
       LinuxKernel Newbies <kernelnewbies@nl.linux.org>
In-Reply-To: <20041001205727.GA30680@outpost.ds9a.nl>
References: <1096658210.9342.1525.camel@arcane>
	 <20041001205727.GA30680@outpost.ds9a.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1096667431.9342.1534.camel@arcane>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 01 Oct 2004 14:50:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry. :(

Here are the configurations ....

(1) The linux kernel version : 2.4.26


(2) md information
---------------------

/dev/md0 on / type ext3 (rw,data=journal)
none on /proc type proc (rw)
/dev/md2 on /var type ext3 (rw,data=journal)
/dev/md7 on /var/nas type ext3 (rw,data=journal)
/dev/md5 on /tmp type ext3 (rw,data=journal)
/dev/md6 on /var/log type ext3 (rw,data=journal)
/dev/md1 on /alt type ext3 (rw,data=journal)
/dev/md3 on /opt type ext3 (rw,data=journal)
/dev/md4 on /mnt type ext3 (rw,data=journal)


(3) Partition Information
----------------------------

All 9 disk (sda-sdi) is partitioned as follows

Disk /dev/sda: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1        51    409657   fd  Linux raid autodetect
/dev/sda2            52       102    409657+  fd  Linux raid autodetect
/dev/sda3           103       111     72292+  82  Linux swap
/dev/sda4           112     30401 243304425    5  Extended
/dev/sda5           112       137    208844+  fd  Linux raid autodetect
/dev/sda6           138       176    313267   fd  Linux raid autodetect
/dev/sda7           177       179     24097   fd  Linux raid autodetect
/dev/sda8           180       205    208844+  fd  Linux raid autodetect
/dev/sda9           206       244    313267   fd  Linux raid autodetect
/dev/sda10          245       267    184747   fd  Linux raid autodetect
/dev/sda11          268     30401 242051352+  83  Linux

---------------

Please let me know if any more info is required. Any help is regarded.

-Shesha

On Fri, 2004-10-01 at 13:57, bert hubert wrote:
> On Fri, Oct 01, 2004 at 12:16:51PM -0700, Shesha B.  Sreenivasamurthy wrote:
> 
> > I have 9 disks raid 1. I pulled out 4 disks, and using raidhotadd I
> > triggered a rebuild on 3 of them. While rebuilding md1, the rebuilding
> > process is stuck at 0.0%. Below is a snapshot of "/proc/mdstat". 
> 
> Please please please tell people what kernel you run with and your exact
> configuration.
-- 
  .-----.
 /       \
{  o | o  } 
     |
    \_/
      

