Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291859AbSBNUIv>; Thu, 14 Feb 2002 15:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291861AbSBNUIo>; Thu, 14 Feb 2002 15:08:44 -0500
Received: from gw.wmich.edu ([141.218.1.100]:42239 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S291859AbSBNUIe>;
	Thu, 14 Feb 2002 15:08:34 -0500
Subject: Re: 2.4.18-rc1
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: skidley <skidley@crrstv.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0202141425240.12470-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.43.0202141425240.12470-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 15:08:15 -0500
Message-Id: <1013717300.734.1.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont understand why you are installing an i2c package anyway.  It's
not needed for the latest version of lm_sensors.   I use the latest
version (2.6.2) with the kernel's own i2c stack and it works fine. 
AFAIK the i2c stack was updated back in the day for the new v4l
drivers.  


On Thu, 2002-02-14 at 13:27, skidley wrote:
> I have compiled 2.4.18-rc1 and when I try to install i2c and lm_sensors
> pkg I get this error:
> 
> make: *** No rule to make target
> `/usr/src/linux/include/linux/modules/dvbdev.ver', needed by
> `kernel/i2c-pport.d'.  Stop.
> 
> I have used the same .config that I used to build several kerenels which
> I have sucessfully installed the i2c pkg with. Which makes me think
> that the particular module isnt in 18-rc1 or it has been changed. 
> What selection in the .config would correspond to dvbdev.ver? 
> -- 
> "Of all the things I've lost I miss my mind the most." -- Ozzy Osbourne
> 
> Chad Young           
> Registered Linux User #195191
> @ http://counter.li.org
> -----------------------------------------------------------------------
> Linux localhost 2.4.18-pre9-ac3 #2 Thu Feb 14 02:10:53 AST 2002 i686 unknown
>  12:50pm  up 29 min,  1 user,  load average: 1.59, 1.61, 1.17
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


