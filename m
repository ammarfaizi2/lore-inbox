Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSE2OGl>; Wed, 29 May 2002 10:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSE2OGk>; Wed, 29 May 2002 10:06:40 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:9487 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S315338AbSE2OGh>; Wed, 29 May 2002 10:06:37 -0400
Message-ID: <3CF4E0E0.9090001@loewe-komp.de>
Date: Wed, 29 May 2002 16:08:32 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9, still USB freeze
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva>	<20020529145010.21d01e80.skraw@ithnet.com>	<3CF4DDE8.1020305@loewe-komp.de> <20020529155849.357ee2b1.skraw@ithnet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On Wed, 29 May 2002 15:55:52 +0200
> Peter Wächtler <pwaechtler@loewe-komp.de> wrote:
> 
> 
>>Stephan von Krawczynski wrote:
>>
>>>Hello,
>>>
>>>as noted for pre8, pre9 freezes still, when connecting a sandisk SDDR-05 to
>>>USB(only device attached), and trying to mount some compact-flash. Or, as
>>>an alternative test, even with no compact flash inserted, when starting up
>>>xcdroast. Both completely freezes the machine.
>>>
>>>pre6 was ok.
>>>
>>>
>>Is that on a SMP machine?
>>
> 
> Yes, this is SMP (Asus CUV4X-D, via chipset), dual PIII.
> 
> 
>>I think usb-storage is not completely SMP safe.
>>I had occasional lockups on SMP - since I connected the readers to UP
>>I had no single lockup. At work I do write a lot of compactflashes.
>>
> 
> Interestingly everything works well with pre6, whereas pre8 and pre9 _always_
> freeze.
> 

I let my SMP box run overnight. WHEN there was a crash when writing CF
(perhaps every 2 weeks or so), THEN I got sometimes BIG problems with
writing even after a reboot - locked up again immediatly.
IIRC my workaround was to remove the modules and load them again
before using them. Yes, sounds weird.
I tried to analyse the problem but gave up. I used usb-uhci on 2.4.9
to 2.4.18-SuSE

