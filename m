Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263074AbTCSPNp>; Wed, 19 Mar 2003 10:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbTCSPNp>; Wed, 19 Mar 2003 10:13:45 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34482 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263074AbTCSPNo>; Wed, 19 Mar 2003 10:13:44 -0500
Date: Wed, 19 Mar 2003 07:07:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Cress, Andrew R" <andrew.r.cress@intel.com>,
       "'Helge Hafting'" <helgehaf@aitel.hist.no>, tlb@rapanden.dk
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Bug 471] New: Root on software raid don't boot on new 2.5 ke	rnel since after 2.5.45
Message-ID: <789890000.1048086440@[10.10.2.4]>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D6E0@hdsmsx103.hd.intel.com>
References: <A5974D8E5F98D511BB910002A50A66470580D6E0@hdsmsx103.hd.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please send emails re bugs back to the submitter, which in this
case was tlb@rapanden.dk (Troels Liebe Bentsen)

--On Wednesday, March 19, 2003 05:50:28 -0800 "Cress, Andrew R" <andrew.r.cress@intel.com> wrote:

> Martin,
> 
> You didn't list your kernel configuration.
> Make sure you have CONFIG_BLK_DEV_MD=y (not =m) for root mirroring.
> This is easy to forget, since the default is =m.
> 
> The others should be able to be modules, however you know that 
> the module interface is radically changed in 2.5.45 and beyond,
> so trying it with the other scsi & raid modules compiled in would 
> be a good test.
> 
> Andy
> 
> -----Original Message-----
> From: Helge Hafting [mailto:helgehaf@aitel.hist.no] 
> Sent: Wednesday, March 19, 2003 5:15 AM
> To: Martin J. Bligh
> Cc: linux-kernel
> Subject: Re: [Bug 471] New: Root on software raid don't boot on new 2.5
> kernel since after 2.5.45
> 
> 
> Martin J. Bligh wrote:
>> http://bugme.osdl.org/show_bug.cgi?id=471
>> 
>>            Summary: Root on software raid don't boot on new 2.5 kernel
> since
>>                     after 2.5.45
> 
> Root on raid-1 works fine for me, with and without devfs.  My kernel has
> no module support, everything is compiled in.  I don't use initrd.
> I have used root-raid with every 2.5 kernel except for a few that had
> raid bugs. (Affecting all raid, the root weren't special.)
> 
> Until recently the root raid always did an unclean shutdown, but this didn't
> cause other trouble than a bootup resync.
> 
> 
> 


