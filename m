Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbTLGWhA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLGWhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 17:37:00 -0500
Received: from ms-smtp-01-qfe0.nyroc.rr.com ([24.24.2.55]:48315 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264558AbTLGWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 17:36:58 -0500
Message-ID: <3FD3AAE5.7090206@maine.rr.com>
Date: Sun, 07 Dec 2003 17:34:13 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sean darcy <seandarcy@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 260t11-bk4 problem -- hung processes
References: <200312062254.RAA26015@clem.clem-digital.net.lucky.linux.kernel> <3FD388F0.3070205@hotmail.com>
In-Reply-To: <3FD388F0.3070205@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bk4-bk5 incremental patch fixes it.


sean darcy wrote:

> Pete Clements wrote:
>
>> With 2.6.0-t11-bk4, mozilla hangs before it can come up.
>> At this point other processes that touch the associated
>> /proc entries hang also (such as a ps). Can not kill the
>> process. Shutdown also hangs.
>>
>> Everything fine with bk3.
>>
>
> Same here.
>
> I can run top. But as soon as I try to start mozilla, top freezes. 
> Other odd processes hang: the shutdown script for cups hangs; uic from 
> qt hangs; startkde hangs ( good thing gnome works! ).
>
> bk3 also works for me. From the bk4 changelog, not clear whats the 
> problem
>
> sean
>

