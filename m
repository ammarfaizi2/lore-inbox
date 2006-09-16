Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWIPR4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWIPR4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWIPR4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:56:10 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:47335 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964865AbWIPR4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:56:09 -0400
Date: Sat, 16 Sep 2006 13:56:07 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916175606.GA2837@Krystal>
References: <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060916173552.GA7362@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:52:51 up 24 days, 15:01,  2 users,  load average: 0.24, 0.21, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > Third run : same LTTng instrumentation, with a kprobe handler 
> > triggered by each event traced.
> 
> where exactly did you put the kprobe handler?

ltt_relay_reserve_slot.

See http://ltt.polymtl.ca/svn/tests/kernel/test-kprobes.c to insert the kprobe.
Tests done on LTTng 0.5.111, on a x86 3GHz with hyperthreading.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
