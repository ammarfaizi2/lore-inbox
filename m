Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317123AbSFFU1C>; Thu, 6 Jun 2002 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSFFU1B>; Thu, 6 Jun 2002 16:27:01 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:35727 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317123AbSFFU1B>;
	Thu, 6 Jun 2002 16:27:01 -0400
Date: Thu, 6 Jun 2002 22:26:59 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206062026.WAA20188@harpo.it.uu.se>
To: jgarzik@mandrakesoft.com, mochel@osdl.org
Subject: Re: 2.5.20 tulip bogosities
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 11:41:55 -0700 (PDT), Patrick Mochel wrote:
>> Run 2.5.19 with the 2.5.20 tulip.  Just copy drivers/net/tulip/* from 
>> 2.5.20 into 2.5.19.
>> 
>> Nothing changed in 2.5.20 tulip that should cause that, AFAICS.  So I 
>> want to narrow down the problem before looking further.
>
>There was a bug in the PCI code that only passed the first device ID the 
>driver supported to the driver's probe callback. It caused a few other 
>oddities. A patch was posted to the list:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=102316813812289&w=2
>
>and is now in Linus' tree. It should fix the problem, if you get a chance 
>to test it...
>
>	-pat

The patch Pat refers to above fixed my tulip problem in 2.5.20.

For completeness I also tested 2.5.19 with 2.5.20's tulip code,
and it worked fine, as expected.

Thanks,

/Mikael
