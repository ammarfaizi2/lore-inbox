Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSFDQoE>; Tue, 4 Jun 2002 12:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSFDQoE>; Tue, 4 Jun 2002 12:44:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31500 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315200AbSFDQoC>; Tue, 4 Jun 2002 12:44:02 -0400
Message-ID: <3CFCE09B.6090007@evision-ventures.com>
Date: Tue, 04 Jun 2002 17:45:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: device model documentation 1/3
In-Reply-To: <Pine.LNX.4.33.0206040904430.654-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

> Bus Types 
> 
> struct bus_type {

...


> 	int	(*bind)		(struct device * dev, struct device_driver * drv);
> };
> 

Please - Why do you call it bind? Does it have something with
netowrking to do? Please just name it attach. This way the old UNIX
guys among us won't have to drag a too big
"UNIX to Linux translation dictionary" around with them.
As an "added bonus" you will stay consistent with -

PCMCIA code base in kernel
USB code base in kernel
IDE code base (well recently)

just to name a few.

Thanks.

