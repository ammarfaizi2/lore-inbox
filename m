Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTAOMMX>; Wed, 15 Jan 2003 07:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbTAOMMX>; Wed, 15 Jan 2003 07:12:23 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:22151 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S266274AbTAOMMW>; Wed, 15 Jan 2003 07:12:22 -0500
Date: Wed, 15 Jan 2003 13:21:19 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timing an application [results]
In-Reply-To: <Pine.LNX.3.95.1030114151412.13840A-101000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.51.0301151316470.7297@dns.toxicfilms.tv>
References: <Pine.LNX.3.95.1030114151412.13840A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all your input on this.

I am using rdtsc, works great.
But a funny thing happens.
Here are the results for a block of code that counts the number players
who are fighting: (in a mud)

A) Pentium II 350, 2.4.20-grsec
about 700us with 250k CPU cycles

B) Pentium IV 1,5 ghz 2.4.20-lowlatency-preemt-aa
about 800us with 130k CPU cycles.

Maybe it is because the patches, but it seems that P4 does the same
longer but with less CPU cycles. Could that be correct?
Maybe something there is inacurate?

Regards,
Maciej Soltysiak

