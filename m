Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJ1Sgz>; Mon, 28 Oct 2002 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJ1Sgz>; Mon, 28 Oct 2002 13:36:55 -0500
Received: from bozo.vmware.com ([65.113.40.131]:25095 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261472AbSJ1Sgy>; Mon, 28 Oct 2002 13:36:54 -0500
Date: Mon, 28 Oct 2002 10:44:20 -0800
From: chrisl@vmware.com
To: Christoph Rohland <cr@sap.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028184420.GB1454@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <elabj7bt.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elabj7bt.fsf@sap.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They are the same as shmfs to linux kernel. Why does vmware not use it
in the first place? It is possible due to some the history reason.

BTW, I have another question. For the 8G memory machine, do we need
to setup 16G swap space? Think about the time it take to write 16G
data, does it still make sense that swap space is twice  as big as
memory?

And the swap partition has limit as 2G. So we need to setup 8 swap
partitions if we want 16G swap.

Thanks

Chris

On Mon, Oct 28, 2002 at 09:28:22AM +0100, Christoph Rohland wrote:
> On Thu, 24 Oct 2002, chrisl@vmware.com wrote:
> > Yes, shmfs seems to be the only choice so far.
> 
> So why don't you use Posix or SYSV shared mem?
> 
> Greetings
> 		Christoph
> 
> 


