Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283531AbRK3H0x>; Fri, 30 Nov 2001 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283533AbRK3H0n>; Fri, 30 Nov 2001 02:26:43 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:44365 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S283531AbRK3H0b>; Fri, 30 Nov 2001 02:26:31 -0500
Date: Fri, 30 Nov 2001 02:26:30 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch to update scsi_debug.c
Message-ID: <20011130022630.B21259@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07138D.41A77811@interlog.com>; from dgilbert@interlog.com on Fri, Nov 30, 2001 at 12:05:17AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <snipped patch/>
> 
> Maybe you may like to consider this effort.

> See:
> http://www.torque.net/sg/sdebug.html
> 
> It runs properly on SMP (Eric's didn't) and supports a
> reasonable number of SCSI commands including READ_16 and
> WRITE_16. [...]

Are you going to merge it? If yes, when?

> BTW I kept scsi_debug.h as most other SCSI adapter drivers
> have .h and .c components.

I think it's a carryover from Space.c days or something of
that nature that serves no useful purpose anymore (only makes
it harder to use vi).

-- Pete
