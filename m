Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262889AbTCSCFK>; Tue, 18 Mar 2003 21:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262892AbTCSCFK>; Tue, 18 Mar 2003 21:05:10 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:34579 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262889AbTCSCFJ>; Tue, 18 Mar 2003 21:05:09 -0500
Date: Tue, 18 Mar 2003 19:15:25 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Terry Barnaby <terry@beam.ltd.uk>
cc: mmadore@aslab.com, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Message-ID: <3733590000.1048040125@aslan.scsiguy.com>
In-Reply-To: <3E76EBD6.7070908@beam.ltd.uk>
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com> <3E71F9CB.706@beam.ltd.uk>
 <525730000.1047663245@aslan.btc.adaptec.com> <3E76EBD6.7070908@beam.ltd.uk>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Would it be possible for you to look at the error message to see
> what it is related to.

The drive has unexpectedly dropped off the bus during a connection.
Without a SCSI bus trace it is impossible to know why the drive might
have done this or if perhaps a glitch on the BSY line is causing the
controller to detect a spurious busfree.

> 2. Would it be possible to determine what may have locked up the drive
> with the previous SCSI driver. I could feed this back to Seagate.

I have my hands too full trying to replicate problems seen with the
latest driver and debug their cause to go back and try and figure
out what an old driver version might have done to upset a drive.

--
Justin

