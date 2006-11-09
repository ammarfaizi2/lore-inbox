Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWKITbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWKITbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWKITbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:31:39 -0500
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:33765
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030375AbWKITbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:31:38 -0500
Message-ID: <45538213.20903@seclark.us>
Date: Thu, 09 Nov 2006 14:31:31 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
CC: Arjan van de Ven <arjan@infradead.org>,
       =?ISO-8859-1?Q?=22=5C=22J=2EA?=
	 =?ISO-8859-1?Q?=2E=5C=22_Magall=F3n=22?= <jamagallon@ono.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl>	 <1163062700.3138.467.camel@laptopd505.fenrus.org>	 <45533DB9.4000405@seclark.us>	 <1163084045.3138.502.camel@laptopd505.fenrus.org>	 <45536653.50006@seclark.us> <1163096630.3138.515.camel@laptopd505.fenrus.org> <45537B09.6020401@seclark.us>
In-Reply-To: <45537B09.6020401@seclark.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:

>Arjan van de Ven wrote:
>
>  
>
>>>ata2.01: ATAPI, max UDMA/33
>>>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
>>>===============****
>>>   
>>>
>>>      
>>>
>>you need a different cable for udma66 than you need for udma33; and a
>>certain capacitor to be able to autodetect which you have...
>>maybe your laptop maker saved himself $0.05 ;)
>> 
>>
>>    
>>
>There is no cable the disk plugs directly into the MB.
>How can I force this to udma 66 or higher - the ide driver accepted  
>idex=ata66 to control this.
>
>  
>
Also the specs for the laptop say it supports ide 100MBps (Ultra DMA 5).
Datová propustnost k IDE:   100 MBps (Ultra DMA 5)

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



