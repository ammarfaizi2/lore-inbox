Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSCLX4R>; Tue, 12 Mar 2002 18:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291148AbSCLXz6>; Tue, 12 Mar 2002 18:55:58 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:40362 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S291102AbSCLXzn>; Tue, 12 Mar 2002 18:55:43 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 12 Mar 2002 15:55:36 -0800
Message-Id: <200203122355.PAA08344@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 		o The NCR53c80-based drivers (according to Alan Cox, there
>> 		  is a new driver in the 2.4.x tree, and I don't want to
>> 		  add a port of that driver to this already huge patch).

>I believe changes to NCR53c80 were recently reverted back because
>these "fixes" lead to massive data corruption.  It is preferable
>that the driver remains unbuildable, and therefore doesn't cause
>data corruption than to be buildable and case data corruption.

	Are you talking about an event that occurred in the 2.4
tree or the 2.5 tree?  Are you saying that the newer driver in
2.4 was reverted back to the older driver (i.e., the one that
is in 2.5), or are you saying that someone made some attempt
at porting the 2.5 tree's NCR53C80 driver the new DMA mapping
interface and then backed them out?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
