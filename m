Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUH1GOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUH1GOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUH1GOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:14:44 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62641 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266898AbUH1GOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:14:39 -0400
Message-ID: <413022CB.8020308@namesys.com>
Date: Fri, 27 Aug 2004 23:14:35 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
CC: Will Dyson <will_dyson@pobox.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <412E10A2.1020801@pobox.com> <412EEC07.30707@namesys.com> <412F7B6D.6010305@pobox.com> <412F7FB8.4010609@blue-labs.org>
In-Reply-To: <412F7FB8.4010609@blue-labs.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> Will Dyson wrote:
>
>> Hans Reiser wrote:
>>
>>> Will Dyson wrote:
>>>
>>
>>
>> String parsing bloats the kernel with code that will be called 
>> rarely, and doing it inside the filesystem module makes for duplicate 
>> code if more than one filesystem does it. But a good common parser 
>> routine (or a kernel api that takes a pre-compiled parse tree) would 
>> reduce the bad taste.
>
>
>
> Like say.. printk() ?  :)
>
or namei()....;-)

Seriously, what we are doing is making namei() more powerful.  That is 
all.  Currently namei() is very simple.  Evolution happens.

Hans
