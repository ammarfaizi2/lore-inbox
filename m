Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934223AbWKYDMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934223AbWKYDMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 22:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934427AbWKYDMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 22:12:52 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:31947 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S934223AbWKYDMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 22:12:51 -0500
Date: Fri, 24 Nov 2006 22:12:49 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 15/16] LTTng 0.6.36 for 2.6.18 : Userspace tracing
Message-ID: <20061125031249.GA25728@Krystal>
References: <20061124220413.GP25048@Krystal> <20061125025448.GA15515@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061125025448.GA15515@linux-mips.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:10:54 up 94 days, 18 min,  2 users,  load average: 0.25, 0.29, 0.25
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Baechle (ralf@linux-mips.org) wrote:
> On Fri, Nov 24, 2006 at 05:04:13PM -0500, Mathieu Desnoyers wrote:
> 
> > Userspace tracing : facility registration and event logging through system
> > call.
> 
> The patch defines the syscall numbers for several architectures but
> doesn't change arch/i386/kernel/syscall_table.S, arch/mips/kernel/scall*.S
> etc.
> 
>   Ralf
> 

Hi Ralf,

I stripped them from my complete version (it is in my instrumentation
patches). Only tracing from user space application is affected. As this is a
minor issue, I will only fix it in my next post.

Thanks,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
