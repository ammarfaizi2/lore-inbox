Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUDJSp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUDJSp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 14:45:26 -0400
Received: from smtp05.web.de ([217.72.192.209]:38321 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261234AbUDJSpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 14:45:16 -0400
Message-ID: <407840E2.3000503@web.de>
Date: Sat, 10 Apr 2004 20:45:54 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: Re: 2.6.5-mjb1
References: <4077A003.2030001@web.de> <49410000.1081609397@[10.10.2.4]>
In-Reply-To: <49410000.1081609397@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> The main thing that looks different is that loops per run is lower.
> What does that mean?

Hmm. Sorry, here seems to be an error with my first run of the -mjb1 
bench. Now, in the second try it has the loops running as the others, I 
think. And a good performance...

x11.log:
cpu_hz = 2.0885e+09
cpu_load=0.800000  loops per run = 645177
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.06248 ms (overrun 0)
within 1ms = 38919, factor = 99.9794%
within 2ms = 38927, factor = 100%
deviation = 0.0216797

proc.log:
cpu_hz = 2.0885e+09
cpu_load=0.800000  loops per run = 645114
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 2.96921 ms (overrun 0)
within 1ms = 15422, factor = 99.987%
within 2ms = 15424, factor = 100%
deviation = 0.0223192

diskwrite.log:
cpu_hz = 2.0885e+09
cpu_load=0.800000  loops per run = 645226
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 4.64053 ms (overrun 2)
within 1ms = 13345, factor = 99.9176%
within 2ms = 13354, factor = 99.985%
deviation = 0.0517744

diskcopy.log:
cpu_hz = 2.0885e+09
cpu_load=0.800000  loops per run = 644902
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.45113 ms (overrun 0)
within 1ms = 40427, factor = 99.9357%
within 2ms = 40453, factor = 100%
deviation = 0.0407751

diskread.log:
cpu_hz = 2.0885e+09
cpu_load=0.800000  loops per run = 644972
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.2573 ms (overrun 0)
within 1ms = 38383, factor = 99.9401%
within 2ms = 38406, factor = 100%
deviation = 0.0324159


Marcus
