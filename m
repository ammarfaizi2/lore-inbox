Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWCIBkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWCIBkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWCIBkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:40:13 -0500
Received: from mx0.towertech.it ([213.215.222.73]:63453 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932697AbWCIBkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:40:12 -0500
Date: Thu, 9 Mar 2006 02:39:14 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH 01/16] RTC Subsystem, library functions
Message-ID: <20060309023914.0704da12@inspiron>
In-Reply-To: <20060309012850.GY4006@stusta.de>
References: <20060306015008.858209000@towertech.it>
	<20060306015009.110961000@towertech.it>
	<20060309012850.GY4006@stusta.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006 02:28:50 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Mar 06, 2006 at 02:50:09AM +0100, Alessandro Zummo wrote:
> >...
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-rtc/drivers/rtc/Kconfig	2006-03-05 02:48:31.000000000 +0100
> > @@ -0,0 +1,6 @@
> > +#
> > +# RTC class/drivers configuration
> > +#
> > +
> > +config RTC_LIB
> > +	bool
> >...
> 
> I'd still say this should be a tristate (a MODULE_LICENSE("GPL") in
> rtc-lib.c seems to be the only other change required for this).

 right, I forgot to modify this. applied :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

