Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSCMAX5>; Tue, 12 Mar 2002 19:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291306AbSCMAXr>; Tue, 12 Mar 2002 19:23:47 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:41903 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S291314AbSCMAXa>; Tue, 12 Mar 2002 19:23:30 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 12 Mar 2002 16:23:24 -0800
Message-Id: <200203130023.QAA08389@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Mar 12, 2002 at 03:55:36PM -0800, Adam J. Richter wrote:
>> 	Are you talking about an event that occurred in the 2.4
>> tree or the 2.5 tree?  Are you saying that the newer driver in
>> 2.4 was reverted back to the older driver (i.e., the one that
>> is in 2.5), or are you saying that someone made some attempt
>> at porting the 2.5 tree's NCR53C80 driver the new DMA mapping
>> interface and then backed them out?

>Someone had a go at "making 2.5 compile" without taking Alan's 2.4
>changes. It went into Linus tree.  It got subsequently reverted
>because of the reasons I outlined in my previous mail.

	Maybe you are thinking of the patches that I posted a
while ago that included an update to some locking changes for
a bunch of the scsi drivers.  Alan spoke up and said that
I should not apply the NCR53C80 part of those patches because
I had made a mistake and becuase there was a newer driver in 2.4,
and provided some tips on porting the 2.4 driver.  I immediately
said I would follow Alan's advice and not submit patches
based on the old NCR53C80-based drivers.

	Maybe you were thinking of some other event when you
said "I believe changes to NCR53c80 were recently reverted back because
these 'fixes' lead to massive data corruption."  If so, I would be
interested in hearing about it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
