Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUADJR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUADJR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:17:29 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:58005 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265149AbUADJR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:17:28 -0500
Message-ID: <3FF7DA24.40802@cyberone.com.au>
Date: Sun, 04 Jan 2004 20:17:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Soeren Sonnenburg <kernel@nn7.de>, Con Kolivas <kernel@kolivas.org>,
       Willy Tarreau <willy@w.ods.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14>
In-Reply-To: <5.1.0.14.2.20040104195316.02151e98@171.71.163.14>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lincoln Dale wrote:

> At 07:09 PM 4/01/2004, Soeren Sonnenburg wrote:
> [..]
>
>> Looking at that how can it not be a scheduling problem ....
>
>
> out of interest, have you tried to see how 2.4.xx compares when 
> compiled with HZ set to 1000?
> (or conversely, 2.6 compiled with HZ set to 100)
>

Or, out of interest, an alternate scheduler?

http://www.kerneltrap.org/~npiggin/w29p2.gz
(applies 2.6.1-rc1-mm1, please renice X to -10 or so)


