Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDMNPm>; Fri, 13 Apr 2001 09:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRDMNPb>; Fri, 13 Apr 2001 09:15:31 -0400
Received: from windsormachine.com ([206.48.122.28]:4621 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S131191AbRDMNPT>; Fri, 13 Apr 2001 09:15:19 -0400
Date: Fri, 13 Apr 2001 09:15:07 -0400 (EDT)
From: Mike Dresser <mdresser@windsormachine.com>
To: Ed Tomlinson <tomlins@cam.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ide-tape is readonly here
In-Reply-To: <01041300541802.06447@oscar>
Message-ID: <Pine.LNX.3.96.1010413091415.26497A-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

back down to 2.2.19, and you'll find you can read your tapes.  From what
Andre explains, the HP Colorado 7/14 and 10/20 aren't completely compliant
with standards.  If you run 2.2.19 and the ide patches, you'll have the
same problems.

On Fri, 13 Apr 2001, Ed Tomlinson wrote:

> Hi,
> 
> Upgraded to ac5 tonight.  Problems with 8139too.o
> caused a few crashes and scrambled a few files.
> Restoring them was fun.  Seems that while ide-tape
> can write to my 'HP Colorado 20G' drive, it gets
> an I/O error when it trys to read...  If I flip to 
> ide-scsi and friends (much slower for backups btw)
> the restore works.
> 
> What is needed to debug this?
> 
> Ed Tomlinson <tomlins@cam.org>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

