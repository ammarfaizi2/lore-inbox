Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTAKFZT>; Sat, 11 Jan 2003 00:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbTAKFZT>; Sat, 11 Jan 2003 00:25:19 -0500
Received: from waste.org ([209.173.204.2]:38811 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267059AbTAKFZS>;
	Sat, 11 Jan 2003 00:25:18 -0500
Date: Fri, 10 Jan 2003 23:34:00 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More on Linux and iSCSI [info, not flame :)]
Message-ID: <20030111053400.GR14778@waste.org>
References: <20030111033650.GA32137@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111033650.GA32137@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 10:36:50PM -0500, Jeff Garzik wrote:
> So I thought I would inject some info into the discussion. :)
> 
> Oliver Xymoron (and others?) mentioned that one could do iSCSI in
> userspace.  Well, Intel has code at
> 	http://sourceforge.net/projects/intel-iscsi

The included userspace server is largely proof-of-concept code and
could do with a fair amount of rounding out. Things this could use to
make it interesting:

 - authentication
 - run-time configuration
 - ability to serve from files and block devices (MD, LVM, crypto-loop)
 - ability to serve from /dev/sgX interfaces with native SCSI (tapes, CDRW..)

Don't know what the state of interop with other initiators is though.

I'll also point out that for many Linux<->Linux purposes, nbd is a workable
substitute. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
