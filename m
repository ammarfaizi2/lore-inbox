Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319010AbSHFHzn>; Tue, 6 Aug 2002 03:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319012AbSHFHzn>; Tue, 6 Aug 2002 03:55:43 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:264 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319010AbSHFHzm>; Tue, 6 Aug 2002 03:55:42 -0400
Date: Tue, 6 Aug 2002 08:59:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30
Message-ID: <20020806085918.A13396@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	vamsi_krishna@in.ibm.com
References: <Pine.LNX.4.44.0208052247380.1171-100000@home.transmeta.com> <20020806073804.690DE4BA4@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020806073804.690DE4BA4@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Aug 06, 2002 at 05:22:15PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 05:22:15PM +1000, Rusty Russell wrote:
> Vamsi, what do you think of this patch?  Is it neccessary to restore
> interrupts before handle_vm86_trap (the original patch didn't do this
> either, not sure if it's required).

Any chance you could split the i386-specific kprobes code into
arch/i386/kernel/kprobes.c instead of bloating traps.c?

