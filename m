Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269471AbTCDOJV>; Tue, 4 Mar 2003 09:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269470AbTCDOJV>; Tue, 4 Mar 2003 09:09:21 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:6876 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S269469AbTCDOJU>;
	Tue, 4 Mar 2003 09:09:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>, David Anderson <david-anderson2003@mail.com>
Subject: Re: I/O Request [Elevator; Clustering; Scatter-Gather]
Date: Tue, 4 Mar 2003 22:10:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20030304133201.18619.qmail@mail.com> <20030304135000.GA29990@suse.de>
In-Reply-To: <20030304135000.GA29990@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030304141948.264C63BF9D@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 March 2003 14:50, Jens Axboe wrote:
> > Do Clustering of request and scatter-gather mean the same ?? Confused
> > to the core... Kindly help me ...
>
> No, the elevator clustering refers to clustering request that are
> contigious on disk. Scatter-gather may cluster sg entries that are
> contigious in memory.

Hi Jens,

I think you meant to write *non*contiguous in memory (but contiguous on the 
device).

Regards,

Daniel
