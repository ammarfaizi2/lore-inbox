Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311239AbSDAJpG>; Mon, 1 Apr 2002 04:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311244AbSDAJo5>; Mon, 1 Apr 2002 04:44:57 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:11651 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S311239AbSDAJop>;
	Mon, 1 Apr 2002 04:44:45 -0500
Message-ID: <3CA82C0B.98CD7275@colorfullife.com>
Date: Mon, 01 Apr 2002 11:44:43 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre1-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jason Czerak <Jason-Czerak@Jasnik.net>, linux-kernel@vger.kernel.org
Subject: Re: ECC memory and SMP lockups on Gateway 6400 server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Recently got the goahead to upgrade the Gateway Win2K server to a linux
> box to replace out old webserver. It's a 6400 server. 2 PIII-733's, 704
> megs ECC registered ram.. NT ran fine on this box. not a hitch.
> 
Could you check /proc/interrupts? Is one number extremely high?

And try to boot with "mem=690M". My sis boards become extremely slow if
I don't limit the memory. I guess the e820 map is wrong, and one of the
pages are actually power managmenet registes/NVS.

--
	Manfred
