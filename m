Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWCVUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWCVUwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWCVUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:52:20 -0500
Received: from mxsf31.cluster1.charter.net ([209.225.28.130]:15234 "EHLO
	mxsf31.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932717AbWCVUwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:52:20 -0500
X-IronPort-AV: i="4.03,119,1141621200"; 
   d="scan'208"; a="920937217:sNHT18515074"
Message-ID: <4421B8EA.3020505@cybsft.com>
Date: Wed, 22 Mar 2006 14:51:54 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com>	 <20060321211653.GA3090@elte.hu> <4420B5F0.6000201@cybsft.com>	 <20060322062932.GA17166@elte.hu> <44215CCB.1080005@cybsft.com>	 <442176EB.1050403@cybsft.com> <1143048688.9127.2.camel@localhost.localdomain>
In-Reply-To: <1143048688.9127.2.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Wed, 2006-03-22 at 10:10 -0600, K.R. Foley wrote:
> 
>> Found something interesting. Having Wakeup latency timing turned on
>> makes a HUGE difference. I turned it off and recompiled and now I am
>> seeing numbers back in line with what I expected from 2.6.16-rt4. Sorry,
>> but I had no idea it would make that much difference. I don't have a
>> complete run yet, but I have seen enough to know that I am not seeing
>> tons of missed interrupts and the highest reported latency thus far is
>> 61 usec.
> 
> Just Wakeup latency timing , and not latency tracing ?
> 
> Daniel
> 
> 

Unfortunately I can't say for sure because I don't remember turning it
off, but looking at the log it appears as though latency tracing was
turned on

-- 
   kr
