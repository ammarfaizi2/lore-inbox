Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTH1KIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTH1KHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:39 -0400
Received: from vlan303.core-sw2.iinet.net.au ([203.59.3.45]:30628 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262489AbTH1Jde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:33:34 -0400
Message-ID: <3F4DCC65.2010106@cyberone.com.au>
Date: Thu, 28 Aug 2003 19:33:25 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nico-linux-admin-ml@schottelius.org>
CC: Ross Clarke <encrypted@geekz.za.net>,
       Linux-Admin <linux-admin@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Crazy load average & unkillable processes
References: <3F4D339A.8010907@geekz.za.net> <20030828085549.GB264@schottelius.org>
In-Reply-To: <20030828085549.GB264@schottelius.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nico Schottelius wrote:

>Very interesting..
>with the test4 I experiene the same/similar problems on my laptop..
>all of sudden yesterday several programs died -> Out of Memory.
>I ran
>   Xfree
>   dhcpcd
>   opera 
>   several xterms (about 6)
>   qmail
>   named
>
>first opera was Out of Memory, then died the whole X system with all
>xterms and X beeing Out of Memory.
>
>MemTotal:       385600 kB
>
>which should be more than enough!
>

You might have a process with a memory leak. How much free memory do
you have before everything dies? How much swapping activity is going
on? What do /proc/meminfo and /proc/slabinfo say?


