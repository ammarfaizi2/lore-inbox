Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSHFXDw>; Tue, 6 Aug 2002 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSHFXDw>; Tue, 6 Aug 2002 19:03:52 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:39857 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316408AbSHFXDo>; Tue, 6 Aug 2002 19:03:44 -0400
Message-ID: <3D505758.8090002@t-online.de>
Date: Wed, 07 Aug 2002 01:10:16 +0200
From: Ingo.Adlung@t-online.de (Ingo Adlung)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4.1) Gecko/20020314 Netscape6/6.2.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18/18 scsi core changes
References: <200208051830.50713.arndb@de.ibm.com> <200208052008.35187.arndb@de.ibm.com> <20020805181234.B16035@infradead.org> <200208061306.03627.arnd@bergmann-dalldorf.de> <20020806101807.A16350@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:

> On Tue, Aug 06, 2002 at 01:06:03PM +0200, Arnd Bergmann wrote:
> 
>>Still, it's the stuff IBM recommends for use and it's not going
>>away (at least not in 2.4), so I guess it might just as well be 
>>included.
>>
> 
> Following that argumentation we could also include the broken qlogic driver
> and the nvidia glue..
> 

Well, if the hardware implementation would always be straight forward to 
what you know from PCs, it wouldn't be required to apply additional 
patches to the common code, but it would be easy to stay within the 
architecture specifics. Unfortunately it is not always that easy, by 
large related to virtualization issues ... not an excuse, but an 
explanation. Those not intending to use Linux on IBM's mainframes, and 
what's worth in this context its FCP support can safely ignore the SCSI 
related patch. Anybody else will need it - but you're welcome to show 
alternatives, I'm sure the folks having written the code do very much 
appreciate any guidance you can provide 'em getting to a nicer/cleaner 
implementation finding everybody's appreciation :-)

Ingo




