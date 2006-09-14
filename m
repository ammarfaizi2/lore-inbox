Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWINTLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWINTLB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWINTLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:11:00 -0400
Received: from opersys.com ([64.40.108.71]:24592 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751042AbWINTLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:11:00 -0400
Message-ID: <4509AB9E.2090909@opersys.com>
Date: Thu, 14 Sep 2006 15:21:02 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: grundig <grundig@teleline.es>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, mingo@elte.hu,
       mathieu.desnoyers@polymtl.ca, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, mingo@redhat.com, gregkh@suse.de,
       tglx@linutronix.de, zanussi@us.ibm.com, ltt-dev@shafik.org,
       michel.dagenais@polymtl.ca
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal>	<20060914112718.GA7065@elte.hu>	<450971CB.6030601@mbligh.org> <20060914210307.2cd10da4.grundig@teleline.es>
In-Reply-To: <20060914210307.2cd10da4.grundig@teleline.es>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


grundig wrote:
> IOW, no distro will enable it by default to avoid the overhead,

Please bear in mind that this is an implementation issue. As I've
explained elsewhere, there are ways to implement this where even
compiled-in static tracepoints have practically no cost at all
-- being noops until enabling. Thereby being no justification for
not actually shipping with such built kernels and, therefore,
no reason why tools such as ltt can't real-world usage.

Karim

