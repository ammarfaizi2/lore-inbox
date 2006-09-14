Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWINNlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWINNlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWINNlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:41:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14747 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750748AbWINNlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:41:35 -0400
Date: Thu, 14 Sep 2006 15:40:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914112718.GA7065@elte.hu>
Message-ID: <Pine.LNX.4.64.0609141537120.6762@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Ingo Molnar wrote:

> i have one very fundamental question: why should we do this 
> source-intrusive method of adding tracepoints instead of the dynamic, 
> unintrusive (and thus zero-overhead) KProbes+SystemTap method?

Could you define "zero-overhead"?
Actual implementation aside having a core number of tracepoints is far 
more portable than KProbes.

bye, Roman
