Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTABWiZ>; Thu, 2 Jan 2003 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTABWiZ>; Thu, 2 Jan 2003 17:38:25 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:61284 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267339AbTABWiY>; Thu, 2 Jan 2003 17:38:24 -0500
Message-ID: <3E14C10E.3060702@google.com>
Date: Thu, 02 Jan 2003 14:45:34 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Lionel Bouton <Lionel.Bouton@inet6.fr>,
       Andre Hedrick <andre@linux-ide.org>,
       Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
References: <20030102182932.GA27340@linux.kappa.ro>	<1041536269.24901.47.camel@irongate.swansea.linux.org.uk> 	<3E14B698.8030107@inet6.fr> <1041549847.24901.71.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>#3 Is the above cable electrically able to sustain 66+ UDMA transfers 
>>(could I hack a driver in order to bypass the 80pin cable detection and 
>>make it work properly) ?
>>    
>>
>
>It is possible to do this yes. Other vendors do it as well. Careful
>cable choice lets you meet the electrical requirements other ways in
>certain situations.
>
>
>  
>
on the kernel command line ide0=ATA66 bypasses the check for ide channel 0.

    Ross



