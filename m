Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUHKWch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUHKWch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUHKWch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:32:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57046 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268281AbUHKWce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:32:34 -0400
Date: Thu, 12 Aug 2004 00:32:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
Subject: 2.6: rxrpc compile errors with SYSCTL=n
Message-ID: <20040811223225.GN26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting tons of the following compile errors in 2.6.8-rc4-mm1 (but 
it doesn't seem to be specific to -mm) with CONFIG_SYSCTL=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o(.text+0x154127): In function `__rxrpc_call_acks_timeout':
: undefined reference to `rxrpc_kdebug'
net/built-in.o(.text+0x154167): In function `__rxrpc_call_rcv_timeout':
: undefined reference to `rxrpc_kdebug'
net/built-in.o(.text+0x1541a7): In function `__rxrpc_call_ackr_timeout':
: undefined reference to `rxrpc_kdebug'
net/built-in.o(.text+0x15421e): In function `rxrpc_create_call':
: undefined reference to `rxrpc_ktrace'
net/built-in.o(.text+0x154242): In function `rxrpc_create_call':
: undefined reference to `rxrpc_ktrace'
net/built-in.o(.text+0x154272): In function `rxrpc_create_call':
: undefined reference to `rxrpc_ktrace'
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

