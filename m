Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDEXoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDEXoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWDEXoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:44:12 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:30223 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751194AbWDEXoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:44:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZuoHR9/sBkAz3KFZsGM2jV5UopzpjEAM0OIWNC5AtHM6+rDpmjyDkVxZIBr0iZwguUaJUnyQCW9gu1AIJGr5SmaxtUkOzxnIkDXoNxU+hS2zyybp+TBof+b+CxuvF5gkn8iTvNFYPqRAqI7LqrQjdpAd2IU4WeR2GH+I5KKsAjs=
Message-ID: <44345693.9000208@gmail.com>
Date: Thu, 06 Apr 2006 07:45:23 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Carlos Silva <r3pek@r3pek.homelinux.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
References: <4433C456.7010708@gmail.com> <1144257124.2075.10.camel@localhost>
In-Reply-To: <1144257124.2075.10.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Silva wrote:
> On Wed, 2006-04-05 at 21:21 +0800, Yi Yang wrote:
>   
>> <snip>
>> +static void cleanup_dead_listener(listener * x)
>> +{
>> +	pid_filter * p = NULL, * pq = NULL;
>> +	uid_filter * u = NULL, * uq = NULL;
>> +	gid_filter * g = NULL, * gq = NULL;
>> +
>> +	if (p == NULL)
>> +		return;
>> <snip>
>>     
>
> I think you ment "if (x == NULL)" here.  Otherwise, the condition will always be true.
> btw, I'm not reviewing your code, just stumbled across this while reading it.
>   
Yes, it is my mistake, thank you.
