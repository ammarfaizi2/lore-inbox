Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWDYJAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWDYJAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWDYJAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:00:45 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:15880 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932146AbWDYJAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:00:45 -0400
Message-ID: <444DE539.4000804@argo.co.il>
Date: Tue, 25 Apr 2006 12:00:41 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Xavier Bestel <xavier.bestel@free.fr>,
       "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <mj+md-20060424.201044.18351.atrey@ucw.cz> <444D44F2.8090300@wolfmountaingroup.com> <1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net> <1145952948.596.130.camel@capoeira> <444DE0F0.8060706@argo.co.il> <mj+md-20060425.085030.25134.atrey@ucw.cz>
In-Reply-To: <mj+md-20060425.085030.25134.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 09:00:43.0389 (UTC) FILETIME=[BBC50AD0:01C66846]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
>   
>> That seems to be a case against writing functions.
>>
>> Why is a C function acceptable where a C++ constructor isn't?
>>     
>
> Because examining a single constructor is not enough -- you need to
> check constructors of all objects contained within the object you
> initialize.
>
> Calling a C function is simple and explicit -- a quick glance over
> the code is enough to tell what gets called.
>
>   
No, you need to check all the functions it calls as well.

But I agree that C is more explicit than C++.

-- 
error compiling committee.c: too many arguments to function

