Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284924AbRLZVLr>; Wed, 26 Dec 2001 16:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284952AbRLZVLh>; Wed, 26 Dec 2001 16:11:37 -0500
Received: from f105.law9.hotmail.com ([64.4.9.105]:12550 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S284950AbRLZVLd>;
	Wed, 26 Dec 2001 16:11:33 -0500
X-Originating-IP: [199.172.169.9]
From: "Arturas V" <arturasv@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: avaitaitis@bloomberg.net
Subject: Re: Proliant hangs with 2.4 but works with 2.2. 
Date: Wed, 26 Dec 2001 16:11:27 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F105uevz176RbFGIUUJ0000fff8@hotmail.com>
X-OriginalArrivalTime: 26 Dec 2001 21:11:28.0202 (UTC) FILETIME=[E239D2A0:01C18E51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lafanga lafanga wrote:
>I have a Compaq Proliant 1600 server which can be hung on demand with >all 
>the 2.4 series kernels I have tried (2.4, 2.4.1 & 2.4.2-pre3). >Kernel 
>2.2.16 runs perfectly (from a default RH7.0).

>I have ensured that the server meets the necessary requirements for >the 
>2.4 kernels (modutils etc) and I have tried kgcc and various gcc versions. 
> >When compiling I have tried default configs and also minimalist configs 
>(with only cpqarray and tlan). I have also ensured that I have the latest 
> >current SmartStart CD (4.9) and have setup the firmware for installing 
>Linux.

I had similar problem with 2.4.5 Kernel. I managed to solve the problem by 
configuring a working verion of kernel with
NCR53C8XX SCSI support as well as SYM53C8XX. As far as I understood
SYM53C8xx support covers 53C8xx chips better than NCR53C8xx and that makes 
all the difference. Anyone understands why?
---
Arturas Vaitaitis.
---
Please CC to arturv@acedsl.com
P.S. Intelligence has yet to prove its survival value

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

