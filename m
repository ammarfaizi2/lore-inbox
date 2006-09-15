Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWIOU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWIOU0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWIOU0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:26:43 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:2021 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751194AbWIOU0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:26:42 -0400
Date: Fri, 15 Sep 2006 16:26:40 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915202640.GB23318@Krystal>
References: <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <1158352633.29932.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1158352633.29932.141.camel@localhost.localdomain>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:25:28 up 23 days, 17:34,  2 users,  load average: 0.18, 0.28, 0.34
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> In addition ideally we want a mechanism that is also sufficient that
> printk can be mangled into so that you can pull all the printk text
> strings _out_ of the kernel and into the debug traces for embedded work.
> 
> [ie you want printk("Oh dear %s exploded.\n", foo->bar); to end up with
> "Oh dear %s exploded.\n" out of kernel and in kernel
> 
> 		tracepoint_printk(foo->bar);
> 

Good idea, trivial to implement on top of LTTng. When seeing printk's reentrancy
limitations, I have though about doing it a couple of times.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
