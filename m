Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbTC2BNo>; Fri, 28 Mar 2003 20:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263371AbTC2BNo>; Fri, 28 Mar 2003 20:13:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52883 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263370AbTC2BNn>; Fri, 28 Mar 2003 20:13:43 -0500
Date: Fri, 28 Mar 2003 17:17:36 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Mary Edie Meredith <maryedie@osdl.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [OSDL][BENCHMARK] DBT-2  2.5.65/mjb/osdl comparison data
Message-ID: <20030328171736.A23820@beaverton.ibm.com>
References: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net> <20030328152516.A22557@beaverton.ibm.com> <1048895544.2532.342.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048895544.2532.342.camel@ibm-e.pdx.osdl.net>; from maryedie@osdl.org on Fri, Mar 28, 2003 at 03:52:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 03:52:24PM -0800, Mary Edie Meredith wrote:
> No, I didn't capture read profiles on the non-cached cases.  I will be
> collecting readprofile on all cases when I go to 2.5.66, but I didn't on
> this round.
> 
> If you have a special interest, I can go back and get the data.  It
> takes 2hrs per kernel.  If you could identify a subset most interesting
> to you, I can do those first.

I am wondering if you are seeing any lock contention for the
host_lock/queue_lock in scsi.

There are some patches not in mainline that I would like to see run
against a multi-disk IO intensive benchmark.

They are currently applied in this bk tree:

bk://linux-scsi.bkbits.net/scsi-locking-2.5

Or, I could send you a patch against 2.5.66.

If you can run with the above and compare to 2.5.66 I would appreciate it
(readprofiles for both cases would still be useful). I would hope to see
at least lower system times.

Thanks.

-- Patrick Mansfield
