Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSIBPq4>; Mon, 2 Sep 2002 11:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSIBPq4>; Mon, 2 Sep 2002 11:46:56 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:56592 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S318290AbSIBPq4>; Mon, 2 Sep 2002 11:46:56 -0400
Date: Mon, 02 Sep 2002 09:50:11 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: CAMTP guest <camtp.guest@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <1231170000.1030981811@aslan.scsiguy.com>
In-Reply-To: <15731.22574.493121.798425@proizd.camtp.uni-mb.si>
References: <15731.22574.493121.798425@proizd.camtp.uni-mb.si>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running 2.4.19, using AIC7XXX 6.2.8.
> SCSI devices are 0:0:0 hard disk and 0:6:0 CDR.
> During CD burning, errors sometimes occur and aic7xxx driver
> sets the CDR offline. Is there a way to reset the device and
> set it online again _without_rebooting_ ?

I don't know that any mechanism currently exists.  It shouldn't be
too hard to create on though.  Just modify the proc handler in 
drivers/scsi/scsi.c.

While your looking at that, I would like to better understand why the
device is being set offline.  The message listing you've provided is
not complete.  If you send me all of the messages output by the driver
from boot through failure I will try to diagnose your problem.

--
Justin
