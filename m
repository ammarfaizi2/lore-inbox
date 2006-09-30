Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWI3TCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWI3TCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWI3TCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:02:20 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:13277 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751432AbWI3TCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:02:19 -0400
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
From: Nicholas Miell <nmiell@comcast.net>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
In-Reply-To: <20060930180157.GA25761@Krystal>
References: <20060930180157.GA25761@Krystal>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 12:02:13 -0700
Message-Id: <1159642933.2355.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 14:01 -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> Following the huge discussion thread about tracing/static vs dynamic
> instrumentation/markers, a consensus seems to emerge about the need for a
> marker system in the Linux kernel. The main issues this mechanism addresses are:
> 
> - Identify code important to runtime data collection/analysis tools in tree so
>   that it follows the code changes naturally.
> - Be visually appealing to kernel developers.
> - Have a very low impact on the system performance.
> - Integrate in the standard kernel infrastructure : use C and loadable modules.
> 
> The time has come for some performance measurements of the Linux Kernel Markers,
> which follows. I attach a PDF with tables and charts which condense these
> results.

Has anyone done any performance measurements with the "regular function
call replaced by a NOP" type of marker?

-- 
Nicholas Miell <nmiell@comcast.net>

