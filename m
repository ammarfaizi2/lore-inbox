Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276445AbRJKO3L>; Thu, 11 Oct 2001 10:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJKO26>; Thu, 11 Oct 2001 10:28:58 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54250 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276445AbRJKO2r>; Thu, 11 Oct 2001 10:28:47 -0400
Message-ID: <3BC5ACBE.9B2FD816@redhat.com>
Date: Thu, 11 Oct 2001 10:29:18 -0400
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 oops
In-Reply-To: <Pine.LNX.4.33.0110101540080.2918-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 10 Oct 2001, Bob Matthews wrote:
> >
> > I've received an oops while booting 2.4.11 on two different SMP
> > machines.  The kernel was SMP, HIGHMEM=64G with sym53c8xx, 3c59x,
> > eepro100, aic7xx and megaraid drivers statically linked.
> 
> With CONFIG_SLAB_DEBUG on?
> 
> Slab debugging is not compatible with HIGHMEM=64G as-is

Ah yes, that was it.  I try again with mem alloc debugging turned off.

-- 
Bob Matthews
Red Hat, Inc.
