Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269844AbTGKJS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266644AbTGKJS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:18:56 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:15633 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S269844AbTGKJSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:18:54 -0400
Message-ID: <3F0E85E6.7050001@kolumbus.fi>
Date: Fri, 11 Jul 2003 12:39:50 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: YOSHIFUJI@vger.kernel.org
CC: pekkas@netcore.fi, mika.liljeberg@welho.com, andre@tomt.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
References: <20030711.143926.599349332.yoshfuji@linux-ipv6.org>	<Pine.LNX.4.44.0307111143470.26262-100000@netcore.fi> <20030711.180449.126456521.yoshfuji@linux-ipv6.org>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 11.07.2003 12:34:59,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 11.07.2003 12:34:23,
	Serialize complete at 11.07.2003 12:34:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who adds the subnet router anycast address, kernel itself? Since what? I 
don't see this in 2.5.

--Mika


YOSHIFUJI Hideaki / ???? wrote:

>In article <Pine.LNX.4.44.0307111143470.26262-100000@netcore.fi> (at Fri, 11 Jul 2003 11:46:00 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
>
>  
>
>>>I don't like this
>>>while I would be ok to have configuration option
>>>not to support anycast.
>>>      
>>>
>>With "not to support anycast" you probably meant "not to support
>>subnet-router anycast address [automatically, in the kernel, as now]" ?  
>>These are entirely different things.
>>    
>>
>
>I meant disabling anycast entirely.
>
>  
>
>>(Note that if there's a user-level API for setting anycast addresses, one 
>>could kick the subnet-router anycast address out of the kernel too.  
>>Whether that's desirable is another thing.)
>>    
>>
>
>We have but we cannot; it is refcnt'ed.
>
>--yoshfuji
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


