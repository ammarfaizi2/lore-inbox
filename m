Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSICCtc>; Mon, 2 Sep 2002 22:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSICCtc>; Mon, 2 Sep 2002 22:49:32 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:5806 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id <S318626AbSICCtc>;
	Mon, 2 Sep 2002 22:49:32 -0400
Message-ID: <3D742446.1070403@cox.net>
Date: Mon, 02 Sep 2002 19:53:58 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Bernstein <matt@theBachChoir.org.uk>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: [ot] Re: Stupid anti-spam testings...
References: <Pine.LNX.4.44.0209030044210.12780-100000@jester.mews>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein wrote:
> 
> Anyway I think this kind of paranoia is just silly. It's trivial to forge 
> a valid sender address, so why bother checking anything other than a 
> syntactically valid domain name?
> 

Because, believe it or not, most spammers don't bother. The main server 
that I maintain (_NOT_ where I receive L-K) drops at least 20 messages a 
day at RCPT TO: time using this very check. Considering that's 50% of 
the spam we drop at RCPT TO: time, I'd say it's worth it.

But I do agree, the systems doing the callouts should cache the results 
(I'm an Exim 4.10 user as well).

