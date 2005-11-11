Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVKKPey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKKPey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVKKPey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:34:54 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:23956 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750815AbVKKPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:34:53 -0500
X-ORBL: [67.120.235.193]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject:
	references:in-reply-to:content-type:content-transfer-encoding;
	b=hUNODxgokoejQqXnbndSEf2MVEXKA1WGgywtZxbVdOXofkfIMvBsPCyMHoI95cSo+
	+DSFzzUByXvoGwumq838A==
Message-ID: <4374BA0F.9010101@pacbell.net>
Date: Fri, 11 Nov 2005 07:34:39 -0800
From: Mickey Stein <yekkim@pacbell.net>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: Makefile xconfig problem: qconf libs/cflags
 error
References: <43749921.2010603@pacbell.net> <Pine.LNX.4.61.0511111519470.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511111519470.1609@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
>
> On Fri, 11 Nov 2005, Mickey Stein wrote:
>
>   
>> The actual problem may be at another level, since I don't see a difference
>> between the scripts/kconfig/Makefile & prior ones that work, but this patch
>> seems in line with other targets that work and used the standard pkg-config
>> --libs --cflags setup.
>>     
>
> Interesting, I didn't know pkg-config supports qt, it's a good idea to use 
> it if it's available, but I'd like to avoid to depend on it.
> I'll look into it during the weekend.
>
> bye, Roman
>
>   
Hi Roman,

Thanks. I used it because the other symbols aren't getting set for me 
over the course of the last few kernels.

Mickey
