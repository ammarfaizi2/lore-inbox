Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273233AbRI0PH0>; Thu, 27 Sep 2001 11:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273254AbRI0PHR>; Thu, 27 Sep 2001 11:07:17 -0400
Received: from [200.250.64.5] ([200.250.64.5]:27767 "EHLO nat.brsat.com.br")
	by vger.kernel.org with ESMTP id <S273233AbRI0PHE>;
	Thu, 27 Sep 2001 11:07:04 -0400
Message-ID: <3BB34142.3010508@brsat.com.br>
Date: Thu, 27 Sep 2001 12:09:54 -0300
From: Roberto Orenstein <roberto@brsat.com.br>
Reply-To: roberto@brsat.com.br
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.9-ac15 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: pt-br, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac15 sluggish
In-Reply-To: <1001602003.17481.7.camel@nomade>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> I gave 2.4.9-ac15 a try on my dual-pIII, 700MB
> 
> I tried to run /usb/bin/automake on the gstreamer project (current
> automake has a bug which sucks all ram, gstreamer provides its own)
> 
> with -ac10 no real bad behavior, just automake is working like crazy.
> 
> with -ac15 the system starts disk-trashing immediately, xterms, ssh or
> telnet sessions are unresponsive for 20mn (after that I gave up and
> rebooted)

Did you try Rik's patch on http://www.surriel.com/patches?

I had the same problem and it is fixed with the patch.
patch name is 2.4.9-ac15-age+launder


Roberto

