Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRJQUHU>; Wed, 17 Oct 2001 16:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277144AbRJQUHK>; Wed, 17 Oct 2001 16:07:10 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:40128 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S277143AbRJQUHD>;
	Wed, 17 Oct 2001 16:07:03 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D574@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: Problem with 2.4.14prex and qlogicfc
Date: Wed, 17 Oct 2001 16:07:00 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ok, and to reiterate this is on an x86 system with HIGHMEM enabled?
> Also, just to confirm, you have _not_ applied Jen's block highmem
> patches on top of this 2.4.13-preX tree right?  It is just a vanilla
> 2.4.13-preX tree?
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com
> 

This _is_ and x86 system with HIGHMEM enabled.  The kernel is 2.4.13-pre3
and does _not_ have Jen's block highmem patches.

The hardware:
4 processors(700Mhz Xeon), 4GB ram
45 fibre channel drives, set up in hardware RAID 0/1
2 direct Gigabit Ethernet connections between SPEC SFS prime client and
system under test
reiserfs
all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes to
storage
NFS v3 UDP
