Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbXAISSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbXAISSf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbXAISSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:18:35 -0500
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:32432 "HELO
	smtp101.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932338AbXAISSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:18:31 -0500
X-YMail-OSG: melBUvwVM1kq7rZccKLPDfOFytsYIzRc5EDue8Aqya3FPDVI.AGifhkpi3v0I1yCDS093ewB8xopz1gDYNx0n6MJ4cqBDHxm8ibRka4sfgQmUUbTxfMtis9sRohFyrv0wzCoy.OJ0NJxRat5LIIZKn4t0G6B3qrLuQKBhqYbJcHrXwcDJz74cqREOUd9
Message-ID: <45A3DD50.7040302@metricsystems.com>
Date: Tue, 09 Jan 2007 10:22:08 -0800
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange ethN numbering problem.
References: <E1H45al-0002Xj-00@calista.eckenfels.net> <45A2F218.8010608@metricsystems.com> <20070109040616.ED8C460BE75@tzec.mtu.ru>
In-Reply-To: <20070109040616.ED8C460BE75@tzec.mtu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov schrieb:
> John Clark wrote:
>
>   
>
> Then quite likely it remembered lower numbers for "old" interfaces and
> starts renaming with next available.
>
>   
>> The kernel is 2.6.19.1 the at-that-moment current linux kernel.
>>
>> What should I look for in terms of interface renaming.
>>     
>
> I guess in udev rules; look also if you have /etc/iftab. The best you can do
> is asking in lists/groups dedicated to your distribution.
>
> -andrey

Thanks.

It was 'udev rules' that were messing things up, left over from using 
the disk on a different
piece of hardware. To date I've been making only 'embedded'  systems 
using busybox, and other
similarly limited root environments and never really dealt with a  
pretty much full up distribution
outside of my host development systems. Hence, never really had gotten 
in to 'udev'. I've been
using devfs mostly till recently... However, in anticipation of large 
capacity flash systems, I've moved
to making my embedded systems almost as full up as most host systems.

Is there some startup command line option for the linux kernel to force 
the 'udev' management
program to basically 'ignore and refresh' device names?


John Clark.


