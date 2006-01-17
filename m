Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWAQMko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWAQMko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWAQMko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:40:44 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:29962 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932457AbWAQMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:40:43 -0500
Message-ID: <43CCE5C8.7030605@superbug.demon.co.uk>
Date: Tue, 17 Jan 2006 12:40:40 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
References: <43CA883B.2020504@superbug.demon.co.uk> <20060115192711.GO7142@w.ods.org>
In-Reply-To: <20060115192711.GO7142@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi,
> 
> On Sun, Jan 15, 2006 at 05:36:59PM +0000, James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>I have a python application that kills X. I.e. the X process terminates, 
>>and all X programs receive broken links to the display and therefore 
>>also exit.
>>
>>The problem is, this python application is not supposed to kill 
>>anything, so I think it is a bug in X, but I cannot find any way to 
>>trace the fault. Even gdb says the application was killed, so exited 
>>normally, and results in no back trace.
>>
>>Is there any way in Linux to find out who did the "killing" ?
> 
> 
> Probably that X was killed because your system encountered an OOM
> (out of memory) condition. For instance, if python eats all the
> memory, and if you have not set any memory usage limit with ulimit,
> then you can get anything killed.
> 
> 
>>James
> 
> 
> Willy
> 
> 
> 

My point is that there is no way to tell what kills me. No messages in 
syslog...nothing. Surely the OOM killer would send a message to ksyslog, 
or at least dmesg?

James

