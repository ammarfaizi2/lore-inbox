Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbVJMHCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVJMHCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 03:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVJMHCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 03:02:46 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:20358 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751489AbVJMHCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 03:02:45 -0400
Message-ID: <434E068B.1060607@arcor.de>
Date: Thu, 13 Oct 2005 09:02:35 +0200
From: Klaus Dittrich <kladit@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc* / xinetd
References: <20051012143657.GA1625@xeon2.local.here> <200510121745.j9CHj6XE023497@turing-police.cc.vt.edu>            <434D5574.10405@arcor.de> <200510122013.j9CKDVGV032270@turing-police.cc.vt.edu>
In-Reply-To: <200510122013.j9CKDVGV032270@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Wed, 12 Oct 2005 20:27:00 +0200, Klaus Dittrich said:
>
>  
>
>>service time
>>{
>>    type        = INTERNAL
>>    id          = dgram_time
>>    
>>
>
>That, my friends, is UDP port 37, not UDP port 123 where NTP lives.
>
>  
>

The time requester is a router. I looked up
it's configuration and indeed TIME/UDP is the
protocol used.

You are right, I mixed up ntp with time. Sorry.

So, the corretced message is ..

I noticed a huge cpu usage of xinetd with 2.6.14-rc4
starting with the first time/udp request.

I will try older rc's today to narrow the point in time
this problem started.
--
Klaus
