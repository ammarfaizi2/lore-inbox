Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTKVHnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 02:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTKVHnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 02:43:21 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:43455 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262094AbTKVHnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 02:43:20 -0500
Message-ID: <3FBF1393.9070604@cyberone.com.au>
Date: Sat, 22 Nov 2003 18:43:15 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH][CFT] NUMA / SMP scheduler "improvements"
References: <3FBF0CCF.7060401@cyberone.com.au>
In-Reply-To: <3FBF0CCF.7060401@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> Hi everyone,
> I would like people to test my scheduler improvements if possible,
> if you are interested in that sort of thing. Patch at:
> http://www.kerneltrap.org/~npiggin/w22/


snip

>
> The good metric is the number of tasks being pulled to another node
> dbench pulls    72%
> tbench pulls     0.28% 


So by this I mean that mainline pulled 59469 of their node during
tbench tests, my patch pulled 171.

I have some raw results here:
http://www.kerneltrap.org/~npiggin/w22/results

