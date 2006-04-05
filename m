Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWDEXmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWDEXmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWDEXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:42:55 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:64268 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbWDEXmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:42:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tw6Ar4ryzzgAQtoq3n3wijHnM5pmLC8gg4kJiWfx7HlT1auge8RTT8uG/e+pjvnjNn8JbH8KrhnhiXYP1eC+SwUJEVpdovo0VxbmF+q2s6kl22L1ktLTUxAfhq3TAjud65PDR/BOb93mHXM6DNvUCKoU9iGdQGUqlnzhkVrb078=
Message-ID: <44345641.8010107@gmail.com>
Date: Thu, 06 Apr 2006 07:44:01 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Michael Guo <Michael.Guo@advantechAMT.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
References: <1A60C93388AFD3419AEE0E20A116D3201CFDA1@exch2k>
In-Reply-To: <1A60C93388AFD3419AEE0E20A116D3201CFDA1@exch2k>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Guo wrote:
> Hi,
>   Now, kernel is growing bigger and bigger continuously and performance is becoming slower. So, if possible, please consider to add a 
> common and simple interface which is scalable and flexible to satisfy real requirement of users instead of telling users use this or that like Microsoft. In a word, simple makes application programmers happy!
>
>
> Guo
>   
Your requirement should be done by a userspace library, in fact, most of
functions provided by kernel are exported
to the final application in this way
