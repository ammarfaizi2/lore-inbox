Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTE2NJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTE2NJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:09:35 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:4239 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262220AbTE2NJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:09:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16086.2429.637069.513978@gargle.gargle.HOWL>
Date: Thu, 29 May 2003 09:22:05 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
In-Reply-To: <20030528225913.GA1103@hh.idb.hist.no>
References: <20030408042239.053e1d23.akpm@digeo.com>
	<3ED49A14.2020704@aitel.hist.no>
	<20030528111345.GU8978@holomorphy.com>
	<3ED49EB8.1080506@aitel.hist.no>
	<20030528113544.GV8978@holomorphy.com>
	<20030528225913.GA1103@hh.idb.hist.no>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge> On Wed, May 28, 2003 at 04:35:44AM -0700, William Lee Irwin III wrote:
>> 
>> Could you log this to serial and get the rest of the oops/BUG? If it's
>> where I think it is, I've been looking at end_page_writeback() and so
>> might have an idea or two.

Helge> I tried 2.5.70-mm1 on the dual celeron at home.  This one has
Helge> scsi instead of ide, so I guess it is a RAID-1 problem.
Helge> This machine has root on raid-1 too.  I believe there where
Helge> several oopses in a row, I captured all of the last one
Helge> thanks to a framebuffer with a small font. Here it is:

I've finally gotten 2.5.70-mm1 compiled and bootable on my system, but
with my /home being RAID1, I was getting crashes that looked alot like
this as well.  This was a Dual PIII Xeon 550, with a mix of IDE and
SCSI drives.  /home was on a pair of 18gb SCSI disks, RAID1.  

I also had problems with the new AIC7xxx driver and had to drop back
to the old one to get a boot.  I think.  Lots and lots of confusion
here.

John
