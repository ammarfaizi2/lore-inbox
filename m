Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVLYIHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLYIHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 03:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLYIHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 03:07:13 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:29503 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750801AbVLYIHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 03:07:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IWGe/j9GPns4qNc3srogLm/V/H7f2qRq+DqJTh6pynOcAQnIZ38R6HBwmXwOuNOPBfPt0bZAa7ZF91hfmF0L0SdEnxIEAqNvXovwih5owX0EAzqIzBpLodSHL7+N5Fd6tzCi0CjaKFlAjMP/gpp2LnV4fKz2uKP6CvrFNq3nQT0=
Message-ID: <43AE52B6.1090604@gmail.com>
Date: Sun, 25 Dec 2005 10:05:10 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke-Jr <luke@dashjr.org>
CC: Lee Revell <rlrevell@joe-job.com>, David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU> <1135370197.22177.40.camel@mindpipe> <20051223203347.GA32589@nevyn.them.org> <200512250131.19218.luke@dashjr.org>
In-Reply-To: <200512250131.19218.luke@dashjr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> On Friday 23 December 2005 20:33, Daniel Jacobowitz wrote:
> 
>>Applications have to run on existing platforms and work with existing
>>software, as I'm sure you know.  If someone anywhere in the food chain
>>isn't ready for NPTL, a project can easily be stuck with LT for another
>>few years.
> 
> 
> Not sure about NPTL support in non-Linux-based operating systems (Solaris, 
> BSD, etc), but I'd be surprised if they supported LinuxThreads. Thus, 
> shouldn't NPTL really result in a *more* portable application?
> 

Yes... This is my first recommendation...
But what if the user does not want to upgrade?

Well... I understand that I am left with the following options:
1. upgrade to NPTL
2. My implementation of querying the main in a separate thread.
3. don't use setuid

Thank you for your help,
Alon Bar-Lev.
