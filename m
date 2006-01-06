Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWAFVKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWAFVKm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWAFVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:10:42 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:47271 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932523AbWAFVKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:10:41 -0500
Message-ID: <43BEDCDB.8010102@tmr.com>
Date: Fri, 06 Jan 2006 16:10:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.15
References: <43BDA76F.1000906@pin.if.uz.zgora.pl> <9a8748490601051512w72ea0baekd52d991d2984c017@mail.gmail.com> <43BE9FDA.2020300@pin.if.uz.zgora.pl>
In-Reply-To: <43BE9FDA.2020300@pin.if.uz.zgora.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Luczak wrote:
> Jesper Juhl napisał(a):
> 
>>
>> Try and reproduce with a non-tainted kernel.
>>
> 
> Non-tained kernel works great. There is no oops with that. The real 
> problem is with ndiswrapper + sk98lin conflict. I will try to find 
> solution and fix this conflict.

Are you running 4k stacks? I wouldn't expect ndiswrapper to works at all 
in that case, but...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
