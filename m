Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWITNUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWITNUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWITNUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:20:41 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:6331 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751252AbWITNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:20:40 -0400
Message-ID: <4511401B.4070809@hitachi.com>
Date: Wed, 20 Sep 2006 22:20:27 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal>
In-Reply-To: <20060918234502.GA197@Krystal>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mathieu Desnoyers wrote:
> Hello,
> 
> Following this huge discussion thread, I tried to come with a marker mechanism
> (which is something everyone seems to agree that is a necessity) that would be
> useful to each kind of tracing (dynamic and static) (concerned projects :
> SystemTAP, LKET, LKST, LTTng) and even combinations of those. Religious
> considerations aside, I really think that this kind of generic markup is
> necessary to fill *everybody*'s need. If I forgot about a specific genericity
> aspect, please tell me.
> 
> I take for agreed that both static and dynamic tracing are useful for different
> needs and that a full markup must support both and combinations, letting the
> user or the distribution choose.

Basically, I like this static marker concept.
But I wonder why wouldn't you use the architecture-independent
marker which SystemTap already supports.
If we use NOPs, it highly depends on architecture, and is hard
to port.

Thanks,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com




