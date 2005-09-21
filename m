Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVIUOPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVIUOPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVIUOPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:15:37 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:29582 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1750923AbVIUOPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:15:37 -0400
Message-ID: <43316B2A.4040303@concannon.net>
Date: Wed, 21 Sep 2005 10:16:10 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: spurious mouse clicks
References: <433164F4.40205@concannon.net> <20050921140857.GA17224@irc.pl>
In-Reply-To: <20050921140857.GA17224@irc.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:

>On Wed, Sep 21, 2005 at 09:49:40AM -0400, Michael Concannon wrote:
>  
>
>>I thought it was my imagination at first, but now I have some slightly 
>>more convincing evidence of what is going on...
>>
>>With 2.6.13.1 & 2 as I move my mouse around the screen, I get random 
>>clicks on things the mouse passes.  Seems to happen more often with the 
>>first move from idle, but in general, it is just totally random...
>>
>>With 2.6.9-11.EL and 2.6.12.6 (stock kernel.org) I do NOT get this.
>>
>>Anyone else seeing this?
>>    
>>
>
> Do you have lines like:
>
>psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
>
> in your dmesg?
>
[mike@porthos proc]$ dmesg | grep -i throwing
[mike@porthos proc]$ dmesg | grep -i psmouse

it would appear not...

/mike


