Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbTCSXw1>; Wed, 19 Mar 2003 18:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263275AbTCSXw1>; Wed, 19 Mar 2003 18:52:27 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:8337 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S263272AbTCSXwY>;
	Wed, 19 Mar 2003 18:52:24 -0500
Date: Wed, 19 Mar 2003 18:57:52 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: 2.5.65 jaz drive devfs oops
In-reply-to: <20030319214522.GA7397@bittwiddlers.com>
To: Christoph Hellwig <hch@infradead.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1048550276.2a57f2@bittwiddlers.com>
Message-id: <20030319235752.GA18086@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.3i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
References: <20030319191450.GA23769@bittwiddlers.com>
 <20030319193431.A28725@infradead.org> <20030319214522.GA7397@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, the second test just now didn't work right.
/dev/scsi/host0/bus0/target4/lun0/disc did exist this time around but I got
the same error as before trying to get anything going on it and I can no
longer get the jaz drive to work.  



: So far it's looking good.  I waited until the drive had totally spun down 
: then tried going to it's automount directory and it spun up and mounted fine
: 
:   sdb: Spinning up disk...........ready
:   SCSI device sdb: 2091050 512-byte hdwr sectors (1071 MB)
:   sdb: Write Protect is off
:   sdb: Mode Sense: 39 00 10 08
:   SCSI device sdb: drive cache: write back
:   SCSI device sdb: 2091050 512-byte hdwr sectors (1071 MB)
:   sdb: Write Protect is off
:   sdb: Mode Sense: 39 00 10 08
:   SCSI device sdb: drive cache: write back
:    /dev/scsi/host0/bus0/target4/lun0: p4
:   found reiserfs format "3.6" with standard journal
:   Reiserfs journal params: device sd(8,20), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
:   reiserfs: checking transaction log (sd(8,20)) for (sd(8,20))
:   Using r5 hash to sort names
: 
: I'll try it again in an hour or so with some different tests.  Thanks for the
: patch

-- 
  Matthew Harrell                          If you can't convince them, 
  Bit Twiddlers, Inc.                       confuse them...
  mharrell@bittwiddlers.com     
