Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRAQKV7>; Wed, 17 Jan 2001 05:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131624AbRAQKVu>; Wed, 17 Jan 2001 05:21:50 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:59661 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131492AbRAQKVg>;
	Wed, 17 Jan 2001 05:21:36 -0500
Date: Wed, 17 Jan 2001 11:21:06 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A657212.14DCDD17@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Kelsey Hudson wrote :
> On Tue, 16 Jan 2001, Michael Meissner wrote:
> > I'm an end-user, and I have 3 scsi-adapters of two different brands in my 
> > system. Many of the people using Linux in high end things like servers, 
> > etc. will have multiple scsi controlers. People are using Linux in lots of 
> > things from small embedded devices to large systems, and Linux needs to address 
> > needs in every area. 
> 
> see, thats where you and i disagree...I wouldn't call you an end user
> based upon that fact. End users (IMO) are those people who sit back and
> buy a PC and expect it to Just Work(tm). Servers, embedded devices, et al
> (read: high-end applications) do not equate to end-user applications,
> IMNSHO. Besides, *most* (and I say most because I've seen a sharp decline
> in the mentality of Linux users as of late) people who are going to manage
> a high-scale server are going to know what the hell they are doing in the 
> first place, so I highly doubt that the end-user argument holds merit
> against this.
> 
> Linux, whether you like it or not, is a full-scale UNIX. It takes a good
> (read: talented) system administrator to manage any UNIX properly...A good
> sysadmin reads documentation....Seems clear enough to me. But, then again,   
> this is coming from an experienced sysadmin so my opinion *must* be
> biased.

Recently my neighbor ( in no way a high-end user ) called me over,
because his Linux setup wouldn't boot anymore. All he did was to add
( or maybe remove, can remember now ) a partition on his IDE disk.
Linux assigned different device nodes to the partition as it did before
the change, so it couldn't find its root-fs.

The same problem exists with _all_ devices that are assigned in the
"order I found them today" , like audio devices , network devices etc...

BTW, where is the scsihosts= kernel parameter documented ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
