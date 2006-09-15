Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWIOSKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWIOSKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWIOSKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:10:22 -0400
Received: from opersys.com ([64.40.108.71]:58121 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751344AbWIOSKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:10:20 -0400
Message-ID: <450AEEEB.6040005@opersys.com>
Date: Fri, 15 Sep 2006 14:20:27 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal>	<20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu>	<4509B03A.3070504@am.sony.com>	<1158320406.29932.16.camel@localhost.localdomain>	<Pine.LNX.4.64.0609151339190.6761@scrub.home>	<1158323938.29932.23.camel@localhost.localdomain>	<Pine.LNX.4.64.0609151425180.6761@scrub.home>	<1158327696.29932.29.camel@localhost.localdomain>	<Pine.LNX.4.64.0609151523050.6761@scrub.home>	<1158331277.29932.66.camel@localhost.localdomain>	<450ABA2A.9060406@opersys.com>	<1158332324.29932.82.camel@localhost.localdomain>	<450ABF59.4010301@opersys.com> <20060915104955.ad6c3622.akpm@osdl.org>
In-Reply-To: <20060915104955.ad6c3622.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> Again, I don't see this as a huge problem.  patch(1) is able to keep track
> of specific places within source code even in the presence of quite violent
> changes to that source code.  There's no reason why systemtap support code
> cannot do the same.

If you don't want to listen to my part of the argument then consider
the point of view of those who have maintained systems entirely based
on binary editing, namely systemtap and LKET. It's indicative that
all those who have been involved in tracing, be it by static
instrumentation of code or the use of binary editing, all favor some
form of static markup mechanism of the code.

Karim
