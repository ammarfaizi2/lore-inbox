Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWIROrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWIROrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWIROrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:47:10 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:40154 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751662AbWIROrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:47:09 -0400
Date: Mon, 18 Sep 2006 10:46:58 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jes Sorensen <jes@sgi.com>
Cc: karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060918144658.GC15605@Krystal>
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org> <450BCF97.3000901@sgi.com> <450C20C7.30604@opersys.com> <450E5540.4080205@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450E5540.4080205@sgi.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:42:47 up 26 days, 11:51,  4 users,  load average: 1.42, 1.41, 1.40
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes,

* Jes Sorensen (jes@sgi.com) wrote:
> Everything has performance limitations, you keep running around touting
> that static is the only thing thats not a problem. Now show us the
> numbers!
> 

If I may : I showed in a precedent thread that kprobes impact doubled LTTng's
impact on the system. If you are interested in numbers about LTTng, here they
are :

"The LTTng tracer : A Low Impact Performance and Behavior Monitor for GNU/Linux"
(OLS2006)
http://ltt.polymtl.ca/papers/desnoyers-ols2006.pdf

(and for Ingo : I haven't rerun the tests on your modified kprobes, it will
come in time. But I do not really expect that 30-50 cycles compared to 1500
will make a very big difference.)

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
