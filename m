Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWIPRfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWIPRfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWIPRfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:35:01 -0400
Received: from opersys.com ([64.40.108.71]:60178 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932152AbWIPRfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:35:00 -0400
Message-ID: <450C3A98.4060704@opersys.com>
Date: Sat, 16 Sep 2006 13:55:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Jes Sorensen <jes@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal>
In-Reply-To: <20060916172419.GA15427@Krystal>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Desnoyers wrote:
> The bottom line is :
> 
> LTTng impact on the studied phenomenon : 35% slower
> 
> LTTng+kprobes impact on the studied phenomenon : 73% slower
> 
> Therefore, I conclude that on this type of high event rate workload, kprobes
> doubles the tracer impact on the system.

Amen to that. Hopefully this puts to rest the myth of Mr. Scrub.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
