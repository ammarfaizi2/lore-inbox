Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271833AbRH0SbD>; Mon, 27 Aug 2001 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRH0Say>; Mon, 27 Aug 2001 14:30:54 -0400
Received: from archive.osdlab.org ([65.201.151.11]:46816 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S271827AbRH0Sag>;
	Mon, 27 Aug 2001 14:30:36 -0400
Message-ID: <3B8A9070.AD43D0E7@osdlab.org>
Date: Mon, 27 Aug 2001 11:24:48 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Journal FS Comparison on IOzone (was Netbench)
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am doing some similar FS comparisons, but using IOzone
(www.iozone.org)
instead of Netbench.

Some preliminary (mostly raw) data are available at:
http://www.osdlab.org/reports/journal_fs/
(updated today).

I am using a Linux 2.4.7 on a 4-way VA Linux system.
It has 4 GB of RAM, but I have limited it to 256 MB in
accordance with IOzone run rules.

However, I suspect that this causes IOzone to measure disk
subsystem or PCI bus performance more than it does FS performance.
Any comments on this?

Default configurations for all filesystems were used.

Future:
. measure operations/second
. kernel profiling
. measure CPU utilization for each FS
. make graphs more readable
. do some FS comparison graphs


Regards,
~Randy


Andrew Theurer wrote:
> 
> Hello all,
> 
> I recently starting doing some fs performance comparisons with Netbench
> and the journal filesystems available in 2.4:  Reiserfs, JFS, XFS, and
> Ext3.  I thought some of you may be interested in the results.  Below
> is the README from the http://lse.sourceforge.net.  There is a kernprof
> for each test, and I am working on the lockmeter stuff right now.  Let
> me know if you have any comments.
> 
> Andrew Theurer
> IBM LTC
