Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbTCVKxw>; Sat, 22 Mar 2003 05:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262165AbTCVKxw>; Sat, 22 Mar 2003 05:53:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:6372 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262161AbTCVKxu>;
	Sat, 22 Mar 2003 05:53:50 -0500
Date: Sat, 22 Mar 2003 03:04:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: dougg@torque.net
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Message-Id: <20030322030419.1451f00b.akpm@digeo.com>
In-Reply-To: <3E7C4251.4010406@torque.net>
References: <200303211056.04060.pbadari@us.ibm.com>
	<3E7C4251.4010406@torque.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 11:04:16.0250 (UTC) FILETIME=[C7645DA0:01C2F062]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert <dougg@torque.net> wrote:
>
> > Slab:           464364 kB

It's all in slab.

> I did notice a rather large growth of nodes
> in sysfs. For 84 added scsi_debug pseudo disks the number
> of sysfs nodes went from 686 to 3347.
> 
> Does anybody know what is the per node memory cost of sysfs?

Let's see all of /pro/slabinfo please.

