Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTJDEDb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 00:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTJDEDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 00:03:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:39884 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261731AbTJDEDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 00:03:30 -0400
Message-ID: <3F7E46AB.3030709@onlinehome.de>
Date: Sat, 04 Oct 2003 06:03:55 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: getting timestamp of last interrupt?
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.fvjdidn.13ni70f@ifi.uio.no>
In-Reply-To: <fa.fvjdidn.13ni70f@ifi.uio.no>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 2 Oct 2003, Hans-Georg Thien wrote:
> 
> 
>>I am looking for a possibility to read out the last timestamp when an
>>interrupt has occured.
>>
>>e.g.: the user presses a key on the keyboard. Where can I read out the
>>timestamp of this event?
> 
> 
> You can get A SIGIO signal for every keyboard, (or other input) event.
> What you do with it is entirely up to you. Linux/Unix doesn't have
> "callbacks", instead it has signals. It also has select() and poll(),
> all useful for handling such events. If you want a time-stamp, you
> call gettimeofday() in your signal handler.
> 
Thanks a lot Richard,

... but ... can I use signals in kernel mode?


