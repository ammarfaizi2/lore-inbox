Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJ1TW0>; Mon, 28 Oct 2002 14:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJ1TW0>; Mon, 28 Oct 2002 14:22:26 -0500
Received: from bozo.vmware.com ([65.113.40.131]:57352 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261528AbSJ1TWZ> convert rfc822-to-8bit; Mon, 28 Oct 2002 14:22:25 -0500
Date: Mon, 28 Oct 2002 11:29:55 -0800
From: chrisl@vmware.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Rohland <cr@sap.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028192955.GB1564@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <elabj7bt.fsf@sap.com> <20021028184420.GB1454@vmware.com> <20021028192214.GI13972@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20021028192214.GI13972@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 08:22:14PM +0100, Andrea Arcangeli wrote:
> 
> swap space doesn't need to be twice as big as ram. That's fixed long
> ago.
> 
> swap+ram is the total amount of virtual memory that you can use in
> vmware.

Cool.

> 
> > 
> > And the swap partition has limit as 2G. So we need to setup 8 swap
> > partitions if we want 16G swap.
> 
> that's a silly restriction of mkswap, the kernel doesn't care, it can
> handle way more than 2G (however there's an high bound at some
> unpractical level, to go safe the math limit should be re-encoded in
> mkswap, of course it changes for every arch because the pte layout is
> different).

Thanks

Chris



