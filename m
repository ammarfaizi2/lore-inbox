Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWJFKTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWJFKTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWJFKTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:19:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:61965 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932186AbWJFKT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:19:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Da97DgHlismrzZY0wPfSwxP7Tkz+iu4ziqQOhRGf3r6IWn24zeBeiJiOGhKP6i4GNBHmYr773vCGMbRx/51XxRxpNnmMTDJUN2g4cgnvqj0F25MjVR/OHkDfcfjtMNe1trYBWD22PvZ8UtW13y7wsFWZ7z4+jeKsD6oiN3lXYD4=
Message-ID: <98975a8b0610060319u30b6862as886232e9bb5a3723@mail.gmail.com>
Date: Fri, 6 Oct 2006 12:19:29 +0200
From: "=?ISO-8859-2?Q?Witold_W=B3adys=B3aw_Wojciech_Wilk?=" 
	<witold.wilk@gmail.com>
To: "Uwe Zeisberger" <zeisberg@informatik.uni-freiburg.de>,
       "Witold W?adys?aw Wojciech Wilk" <witold.wilk@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: how to get the kernel to be more "verbose"?
In-Reply-To: <20061006094348.GB11065@informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <98975a8b0610052234p3287ab8fr70335f858ba4583b@mail.gmail.com>
	 <20061006073303.GA5105@cepheus.pub>
	 <98975a8b0610060038t4d5dbd14ja348ce78351a93e3@mail.gmail.com>
	 <20061006094348.GB11065@informatik.uni-freiburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/6, Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>:
> > No, I've used the config I had in the 2.6.8 (in proc/config.gz), but
> > the SAME kernel 2.6.8 source compiled incorrectly. So I think this
> > might be some glitch on my machine... because it is im possible to
> > make a kernel that is always getting stuck in the same place.
> Did you notice that Debian kernels are not vanilla but patched?
> You can get the patches from http://packages.debian.org/

OK, I'll check them out. Maybe they did patch them somewhere... But if
such a patch exist I think it should be for quite some time in the
mainstream, because this is quite a critical kernel bug, that it
crashes down.

> > >You can try the "initcall_debug" kernel parameter to see which init
> > >functions are called.
> > I will use that then. I am quite new to debugging the kernel... My
> > programming knowledge is still quite low ;) But I will try that today
> > after work... I will write more. I need to get the Wi-Fi working ASAP.
> Another thing that could help you is SysRQ, there is a request that
> prints out a stack dump.

Unfortunately the SysRQ does not respond. I've tried that to reboot,
shutdown, etc the system after the crash. There is simply no response.
I've tried even compiling into the kernel some really abstract
drivers, just in case I forgot something. I've managed once even a
2.5MB kernel image ;) unfortunately it got stuck just like the rest.

Thanks again, I'll write something more through the weekend, maybe I
will solve this... at least I hope so.
-- 
Witold Wladyslaw Wojciech Wilk Et39m:+48605066384 gg3211630 (lepiej @)
prr: giant boulder'02 @13kkm - brak czasu :( / tychy-sosnowiec-gliwice
pms: vw golf 2 byl, juz sprzedany :) / pierwszeimie.nazwisko@gmail.com
pms/kc: citroen xantia mkI 2.0 8v 1995 225kkm/17kkm hydrokomfortowa :)
