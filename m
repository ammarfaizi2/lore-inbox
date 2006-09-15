Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWIOFsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWIOFsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 01:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWIOFsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 01:48:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4741 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750767AbWIOFsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 01:48:14 -0400
Message-ID: <450A3E8E.7090700@us.ibm.com>
Date: Thu, 14 Sep 2006 22:47:58 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap <systemtap@sourceware.org>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home> <20060914202452.GA9252@elte.hu> <20060915014726.GD23664@Krystal>
In-Reply-To: <20060915014726.GD23664@Krystal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:

>* Ingo Molnar (mingo@elte.hu) wrote:
>  
>
>>* Roman Zippel <zippel@linux-m68k.org> wrote:
>>
>>    
>>
>>>>>>also, the other disadvantages i listed very much count too. Static 
>>>>>>tracepoints are fundamentally limited because:
>>>>>>
>>>>>>            
>>>>>>
>[...]
>  
>
>>Right now they are 
>>pretty heavy cons as far as LTT goes, so obviously they have a primary 
>>impact on the topic at hand (whic is whether to merge LTT or not).
>>
>>    
>>
>
>Ingo, why are you arguing about static instrumentation when I don't submit any
>static instrumentation in my patch ? You can argue about static VS dynamic
>instrumentation all you want, but please don't apply this debate to a dicision
>about including or not a core tracing infrastructure that has nothing to do
>with the way instrumentation or probes are inserted.
>
>Mathieu
>
>
>  
>
I think Ingo is right in saying what we really need first is a generic 
mechanism in how to specify static markers in the kernel which can be 
used to put dynamic probes on demand or use as a real static function 
calls if one chooses. Once we agree on the marker mechanism dynamic 
tracing and static tracing can both co-exist happily.

Coming to your rest of the patches i really don't think we need whole 
lot more than the facilities we already got in the kernel. Frank has 
successfully demonstrated in OLS how one can use static markers by using 
only existing facilities in the kernel.

>OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
>Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


