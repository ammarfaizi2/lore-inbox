Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTAURke>; Tue, 21 Jan 2003 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbTAURke>; Tue, 21 Jan 2003 12:40:34 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:54171
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267137AbTAURke>; Tue, 21 Jan 2003 12:40:34 -0500
Date: Tue, 21 Jan 2003 12:49:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alan <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function_mask
In-Reply-To: <3E2D7FB2.80806@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0301211248570.2653-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Manfred Spraul wrote:

> You can blame me for the mess with smp_call_function:
> 2.2 supported nonatomic calls. I have no idea if that was deadlock free.
> 
> But noone used the 'retry/nonatomic' parameter, noone handled an error 
> return of  smp_call_function (some callers panic).
> Thus I've removed these features from i386, without changing the 
> prototype. I think all archs have picked that up now.
> But retry/nonatomic should not spread into new functions.

Ok i'll send something with forced retry and removing the nonatomic/retry 
parameter completely.

	Zwane
-- 
function.linuxpower.ca

