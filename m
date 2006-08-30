Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWH3XKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWH3XKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWH3XKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:10:48 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:22410 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751607AbWH3XKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:10:47 -0400
Date: Wed, 30 Aug 2006 19:10:46 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH x/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830231045.GA17079@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:04:40 up 7 days, 20:13,  9 users,  load average: 0.38, 0.25, 0.20
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following my presentation "The LTTng Tracer : a low impact performance and
behavior monitor for GNU/Linux" at OLS2006, I think the interest shown by the
community for the LTTng tracer makes it worthy to be announced to LKML so it canbenefit from your input and be eventually mainlined.

Through the discussion some of us had at OLS this year, the emergence of many
ad-hoc tracing tools (RT-preempt latency tracer, Block I/O subsystem tracer)
and of many tracing projects (SystemTAP, LKST, KFT, LTTng) shows the need for
a solid tracing infrastructure, which has been the focus of my work.

The LTTng core fulfills primarily the following goals :
- Serializing information in event records
- Serializing event records
- Must be trivial to use by subsystem maintainers
  - Usable from any execution context
- Relatively simple, minimum side effect
- Identity of the event record
- Flexible types in the event record
- Tracing control mechanism

The project is described in my paper, available in the OLS2006 proceedings or atthe following URL : http://ltt.polymtl.ca/papers/desnoyers-ols2006.pdf. More
information is available at http://ltt.polymtl.ca (see the QUICKSTART guide to
learn how to have the complete set of tools ready to be used).

I hope such an infrastructure will incite kernel developers to instrument
their own subsystem.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
