Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTAUWMA>; Tue, 21 Jan 2003 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTAUWMA>; Tue, 21 Jan 2003 17:12:00 -0500
Received: from havoc.daloft.com ([64.213.145.173]:33702 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267238AbTAUWL7>;
	Tue, 21 Jan 2003 17:11:59 -0500
Date: Tue, 21 Jan 2003 17:21:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: 32bit dev_t
Message-ID: <20030121222101.GA1353@gtf.org>
References: <20030121195041.GE20972@ca-server1.us.oracle.com> <3E2DBBAD.80206@mvista.com> <20030121215602.GI20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121215602.GI20972@ca-server1.us.oracle.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 01:56:02PM -0800, Joel Becker wrote:
> On Tue, Jan 21, 2003 at 02:29:17PM -0700, Steven Dake wrote:
> > Linux doesn't really need a 32 bit kdev_t structure to support 1000 
> > disks.  There is plenty of device space available to support over 1500 
> > disks by modifying the linux scsi layer.
> 
> 	First, that's an approach that removes space from other devices.
> In addition, I suspect we'll see 2000 disk systems before we see 2.8.


Of course, we know the solution is /dev/disk, as mentioned by Linus at
least a couple times, which eliminates a lot of dev_t limitation
issues...  :)

	Jeff



