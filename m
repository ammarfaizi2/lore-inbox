Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbTAaG3J>; Fri, 31 Jan 2003 01:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267711AbTAaG3J>; Fri, 31 Jan 2003 01:29:09 -0500
Received: from smtp2.Stanford.EDU ([171.64.14.116]:21752 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267710AbTAaG3I>; Fri, 31 Jan 2003 01:29:08 -0500
Date: Thu, 30 Jan 2003 22:38:28 -0800 (PST)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@canoe
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 31 potential interprocedural array bounds error/buffer
 overruns in 2.5.53
In-Reply-To: <Pine.LNX.4.33L2.0301302201440.8130-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0301302237310.12030-100000@canoe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good point. Will do.. -yichen

On Thu, 30 Jan 2003, Randy.Dunlap wrote:

> Hi-
> 
> One small thing that we need to see a change/fix to is this summary
> list of file names.  It needs to be more complete, i.e., not dropping
> some parts of the path name.
> 
> 
> | # Summary for
> | #  IP-specific errors       = 31
> | #  /dev/null-specific errors = 0
> | #  Common errors 		      	  = 0
> | #  Total 				  = 31
> | # BUGs	|	File Name
> | 10	|	/media/bt856.c		>should be drivers/media/video/bt856.c
> | 4	|	/drivers/cdu31a.c	>should be drivers/cdrom/...
> | 4	|	/drivers/qlogicisp.c	>should be drivers/scsi/...
> | 2	|	/drivers/cpqfcTSworker.c >should be drivers/scsi/...
> | 1	|	/drivers/sym53c416.c	>ditto
> | 1	|	/media/tvaudio.c	>drivers/media/video/...
> | 1	|	/drivers/eata.c		>drivers/scsi/...
> | 1	|	/drivers/u14-34f.c	>etc. etc. etc.
> | 1	|	/drivers/floppy.c
> | 1	|	/isdn/isdn_common.c
> | 1	|	/media/saa7110.c
> | 1	|	/pnp/core.c
> | 1	|	/drivers/moxa.c
> | 1	|	/drivers/i82092.c
> | 1	|	/drivers/aha1542.c
> 
> Thanks,
> 

