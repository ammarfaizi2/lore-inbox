Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTJDEEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 00:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTJDEEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 00:04:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:13305 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261733AbTJDEEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 00:04:37 -0400
Message-ID: <3F7E46EE.1020201@onlinehome.de>
Date: Sat, 04 Oct 2003 06:05:02 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: getting timestamp of last interrupt?
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.ch95hks.10kepak@ifi.uio.no>
In-Reply-To: <fa.ch95hks.10kepak@ifi.uio.no>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:

> 
> Hans-Georg Thien wrote:
> 
>> I am looking for a possibility to read out the last timestamp when an 
>> interrupt has occured.
>>
>> e.g.: the user presses a key on the keyboard. Where can I read out the 
>> timestamp of this event?
>>
>> To be more precise, I 'm looking for
>>
>> ( )a function call
>> ( ) a callback where I can register to be notified when an event occurs
>> ( ) a global accessible variable
>> ( ) a /proc entry
>>
>> or something like that.
>>
>> Any ideas ?
> 
> 
> Have a look at the Linux Trace Toolkit:
> http://www.opersys.com/LTT/
> It records micro-second time-stamps for quite a few events, including
> interrupts.
> 
thanke a lot for reply Karim,

but I think that LTT does not fit to my needs. It needs to modify the
kernel - and that is what I want to avoid.

I'm looking for a already existing built-in capability.

Maybe signal SIGIO is a solution, if it  does not

(x) give me *every* IO event
(x) has to much overhead - I have to respond to keyboard/mouse events, *not*
     disk events
     grafic card events
     eth event
     etc. ...


- Hans




