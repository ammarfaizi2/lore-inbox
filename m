Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRGJHHm>; Tue, 10 Jul 2001 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265846AbRGJHHc>; Tue, 10 Jul 2001 03:07:32 -0400
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:28171
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S265844AbRGJHHZ>; Tue, 10 Jul 2001 03:07:25 -0400
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200107100707.f6A77Pt17475@frx774.dhs.org>
Subject: Re: Scsi_Cmnd structure
To: mnguyen@ariodata.com (Michael Nguyen)
Date: Tue, 10 Jul 2001 00:07:23 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F01AB55@orion.ariodata.com> from "Michael Nguyen" at Jul 09, 2001 05:21:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
> 
> Can someone help points me to the file location 
> contain Scsi_Cmnd structure in Linux 2.4.x?
> 
> Thank you,
> Michael.

I ran a quick grep through my kernel tree (from SGI's 
CVS, currently at 2.4.7-pre3-xfs) to find out:

grep -nirE '^ *struct +scsi_cmnd' .

returns this:

drivers/scsi/scsi.h:685:struct scsi_cmnd {


Jesse Wyant - jrwyant@_frx774_dhs_org_
------------------------------------------------------------
QOTD:
	I'm not a nerd -- I'm "socially challenged".

