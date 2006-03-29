Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWC2OsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWC2OsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWC2OsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:48:09 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:12265 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1751160AbWC2OsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:48:08 -0500
Message-ID: <442A9E1E.4030707@sw.ru>
Date: Wed, 29 Mar 2006 18:47:58 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Kirill Korotaev <dev@openvz.org>, devel@openvz.org,
       Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org,
       sam@vilain.net
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <4428DB76.9040102@openvz.org> <1143583179.6325.10.camel@localhost.localdomain> <4429B789.4030209@sacred.ru> <1143588501.6325.75.camel@localhost.localdomain> <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at>
In-Reply-To: <20060329134524.GA14522@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wonder what is the value of it if it doesn't do guarantees or QoS?
>> In our experiments with it we failed to observe any fairness. 
> 
> probably a misconfiguration on your side ...
maybe you can provide some instructions on which kernel version to use 
and how to setup the following scenario:
2CPU box. 3 VPSs which should run with 1:2:3 ratio of CPU usage.

> well, do you have numbers?
just run the above scenario with one busy loop inside each VPS. I was 
not able to observe 1:2:3 cpu distribution. Other scenarios also didn't 
showed my any fairness. The results were different. Sometimes 1:1:2, 
sometimes others.

Thanks,
Kirill
