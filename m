Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUHKXBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUHKXBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268318AbUHKW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:58:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16853 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268310AbUHKW4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:56:42 -0400
Date: Thu, 12 Aug 2004 00:56:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com, netdev@oss.sgi.com
Subject: Re: 2.6: rxrpc compile errors with SYSCTL=n
Message-ID: <20040811225634.GR26174@fs.tum.de>
References: <20040811223225.GN26174@fs.tum.de> <20040811224102.GU11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811224102.GU11200@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 03:41:02PM -0700, William Lee Irwin III wrote:
> On Thu, Aug 12, 2004 at 12:32:25AM +0200, Adrian Bunk wrote:
> > I'm getting tons of the following compile errors in 2.6.8-rc4-mm1 (but 
> > it doesn't seem to be specific to -mm) with CONFIG_SYSCTL=n:
> > <--  snip  -->
> > ...
> >   LD      .tmp_vmlinux1
> > net/built-in.o(.text+0x154127): In function `__rxrpc_call_acks_timeout':
> > : undefined reference to `rxrpc_kdebug'
> > net/built-in.o(.text+0x154167): In function `__rxrpc_call_rcv_timeout':
> > : undefined reference to `rxrpc_kdebug'
> 
> Does this help?
>...

Yes.

Thanks for the quick patch!

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

