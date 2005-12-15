Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbVLOKJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbVLOKJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 05:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbVLOKJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 05:09:34 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:21952 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1422685AbVLOKJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 05:09:34 -0500
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
	to David Brownell's core
From: dmitry pervushin <dpervushin@gmail.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
In-Reply-To: <43A05C32.3070501@ru.mvista.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
	 <20051213170629.7240d211.vwool@ru.mvista.com>
	 <20051213195317.29cfd34a.vwool@ru.mvista.com>
	 <200512131101.02025.david-b@pacbell.net> <20051213191531.GA13751@kroah.com>
	 <43A0230B.1040904@ru.mvista.com> <20051214171842.GB30546@kroah.com>
	 <43A05C32.3070501@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 13:00:17 +0300
Message-Id: <1134640817.5596.4.camel@fj-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 20:53 +0300, Vitaly Wool wrote:
> Greg KH wrote:
> 
> >What is the speed of your SPI bus?
> >
> >And what are your preformance requirements?
> >  
> >
> The maximum frequency for the SPI bus is 26 MHz, WLAN driver is to work 
> at true 10 Mbit/sec.
My two cents: the faster is better; SPI bus itself can work on 52MHz,
and AFAIK WLAN developers limit the speed due to their firmware
reqiorements.  
> 
> Vitaly
> 
> P. S. I'm speaking not about this particular case during most part of 
> this conversation. Sound cards behind the SPI bus will suffer a lot more 
> since it's their path to use wXrY functions (lotsa small transfers) 
> rather than WLAN's.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> 
> 

