Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJUQQ0>; Mon, 21 Oct 2002 12:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSJUQQ0>; Mon, 21 Oct 2002 12:16:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33509 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261463AbSJUQQZ>; Mon, 21 Oct 2002 12:16:25 -0400
Date: Mon, 21 Oct 2002 12:23:21 -0400
From: Doug Ledford <dledford@redhat.com>
To: andy barlak <andyb@island.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 scsi _eh_ buslogic
Message-ID: <20021021162321.GC28914@redhat.com>
Mail-Followup-To: andy barlak <andyb@island.net>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.30.0210181201060.29276-100000@tosko.alm.com> <20021018224311.GB1066@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018224311.GB1066@beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 03:43:12PM -0700, Mike Anderson wrote:
> Andy,
> 	From looking at the driver it looks like the locking had been
> update to 2.5, but that the driver error handling has not been updated.
> scsi_obsolete.c has not existed in the 2.5 view for a while.

Actually, I sent a patch to Linus for this driver that I think made it 
into 2.5.44.  Andy, could you let me know if 2.5.44 works?  If not, then 
I'll see what I can find.  Side note: Mike's right about the error 
handling being horked, but that shouldn't really make any difference in 
bootup since it shouldn't be needing error recovery.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
