Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUHJDNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUHJDNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 23:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUHJDNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 23:13:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:39355 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267413AbUHJDNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 23:13:21 -0400
Message-ID: <41183D54.40603@comcast.net>
Date: Mon, 09 Aug 2004 23:13:24 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
References: <Pine.LNX.4.44.0408092246340.25913-100000@dhcp83-102.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408092246340.25913-100000@dhcp83-102.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:
> On Mon, 9 Aug 2004, John Richard Moser wrote:
> 
> 
>>What I'm suggesting isn't much though, is it really? 
> 
> 
> Then why haven't you done it already ? ;)
> 

Alright, it's a big undertaking ;)

> On a more serious note, some other people are already
> auditing the code on a regular basis, while you weren't
> paying attention ...
> 

I'm suggesting things to make code auditing simpler, more accurate, more 
precise.  "Quality-Assurance audited code still contains on average 5 
bugs per kloc" is a really nasty thought.

http://lkml.org/lkml/2004/8/9/369 was the major explaination.  It's big 
and clunky to have before each function; but at least it's not ugly, and 
it's potentially helpful.  Maybe a few of the like in the smallest 
driver possible to see how it feels?  (/dev/mem?)

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

