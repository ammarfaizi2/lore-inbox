Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271672AbRIKR0Y>; Tue, 11 Sep 2001 13:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRIKR0N>; Tue, 11 Sep 2001 13:26:13 -0400
Received: from [205.238.131.251] ([205.238.131.251]:4627 "HELO
	mail.creditminders.com") by vger.kernel.org with SMTP
	id <S268133AbRIKR0C>; Tue, 11 Sep 2001 13:26:02 -0400
Date: Tue, 11 Sep 2001 12:26:23 -0500
From: Erik DeBill <erik@www.creditminders.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs client oops, all 2.4 kernels
Message-ID: <20010911122623.A25304@www.creditminders.com>
In-Reply-To: <20010910100202.A14106@www.creditminders.com> <15261.53031.349271.425562@charged.uio.no> <shsitep7ts9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shsitep7ts9.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Sep 11, 2001 at 03:15:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 03:15:34PM +0200, Trond Myklebust wrote:
> >>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
>      > Could you check if the appended patch works?
> 
> The previous patch had a bug in the rewrite of locks_delete_lock()
> which will Oops/corrupt the inode->i_flock list. Please consign to
> /dev/null, and try the following instead.
> 
> (Note to self: Never attempt to write any patches *before* lunch...)



This patch seems to work.  I'll keep testing, but it's been running
well for an hour or so already.


Thanks,
Erik
