Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934289AbWKYC4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934289AbWKYC4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 21:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934530AbWKYC4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 21:56:01 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:19875 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S934509AbWKYC4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 21:56:00 -0500
Date: Sat, 25 Nov 2006 02:54:48 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
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
Message-ID: <20061125025448.GA15515@linux-mips.org>
References: <20061124220413.GP25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124220413.GP25048@Krystal>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 05:04:13PM -0500, Mathieu Desnoyers wrote:

> Userspace tracing : facility registration and event logging through system
> call.

The patch defines the syscall numbers for several architectures but
doesn't change arch/i386/kernel/syscall_table.S, arch/mips/kernel/scall*.S
etc.

  Ralf
