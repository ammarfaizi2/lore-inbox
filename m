Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269745AbUJWCjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbUJWCjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUJWCjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 22:39:08 -0400
Received: from CPE-203-51-28-190.nsw.bigpond.net.au ([203.51.28.190]:38645
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S269802AbUJWCii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:38:38 -0400
Message-ID: <4179C405.1010805@eyal.emu.id.au>
Date: Sat, 23 Oct 2004 12:37:57 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue... - net/ipv4/netfilter/ipt_hashlimit.c
 does not build
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > Ok,
 >  Linux-2.6.10-rc1 is out there for your pleasure.

   CC [M]  net/ipv4/netfilter/ipt_hashlimit.o
net/ipv4/netfilter/ipt_hashlimit.c: In function `__dsthash_find':
net/ipv4/netfilter/ipt_hashlimit.c:124: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c: In function `__dsthash_free':
net/ipv4/netfilter/ipt_hashlimit.c:173: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c: In function `htable_selective_cleanup':
net/ipv4/netfilter/ipt_hashlimit.c:261: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:261: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c:261: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:269: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:269: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:269: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c: In function `hashlimit_match':
net/ipv4/netfilter/ipt_hashlimit.c:460: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:460: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c:460: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:469: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:469: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:469: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c:482: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:482: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:482: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c:493: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:493: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:493: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c:497: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:497: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:497: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c: In function `dl_seq_start':
net/ipv4/netfilter/ipt_hashlimit.c:572: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:572: error: structure has no member named `l'
net/ipv4/netfilter/ipt_hashlimit.c:572: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c: In function `dl_seq_stop':
net/ipv4/netfilter/ipt_hashlimit.c:606: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:606: error: structure has no member named `locked_by'
net/ipv4/netfilter/ipt_hashlimit.c:606: error: structure has no member named `l'
make[3]: *** [net/ipv4/netfilter/ipt_hashlimit.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

--
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
