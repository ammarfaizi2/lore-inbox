Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVJDNGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVJDNGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVJDNGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:06:16 -0400
Received: from smtpa1.netcabo.pt ([212.113.174.16]:60697 "EHLO
	exch01smtp03.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932439AbVJDNGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:06:15 -0400
Message-ID: <43427E7E.9080205@rncbc.org>
Date: Tue, 04 Oct 2005 14:07:10 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: tsc_c3_compensate undefined since patch-2.6.13-rt13
References: <20050901072430.GA6213@elte.hu> <1125571335.15768.21.camel@localhost.localdomain> <20051003065032.GA23777@elte.hu> <43424B7C.9020508@rncbc.org> <20051004101434.GA26882@elte.hu>
In-Reply-To: <20051004101434.GA26882@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 13:06:04.0289 (UTC) FILETIME=[6040DF10:01C5C8E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> 
>>WARNING: 
>>/lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/char/hangcheck-timer.ko 
>>needs unknown symbol do_monotonic_clock
>>WARNING: 
>>/lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/acpi/processor.ko needs 
>>unknown symbol tsc_c3_compensate
> 
> 
> back then i fixed do_monotonic_clock, but forgot to export 
> tsc_c3_compensate. I have fixed this in my tree, and have uploaded the 
> 2.6.14-rc3-rt3 patch. Does it build without warnings for you now?
> 

OK. Just built 2.6.14-rc3-rt4 and it got thru. Thermal-zone sensor is 
back in town :)

Tks.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


