Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269671AbRHGWMw>; Tue, 7 Aug 2001 18:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269491AbRHGWMm>; Tue, 7 Aug 2001 18:12:42 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9746 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269649AbRHGWMe>;
	Tue, 7 Aug 2001 18:12:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac8 
In-Reply-To: Your message of "Tue, 07 Aug 2001 08:43:06 -0400."
             <200108071243.f77Ch6IN025609@pincoya.inf.utfsm.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Aug 2001 08:12:34 +1000
Message-ID: <23793.997222354@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2001 08:43:06 -0400, 
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>Keith Owens <kaos@ocs.com.au> said:
>> @@ -27,7 +27,6 @@ AIC7XXX_OBJS += aic7xxx_pci.o
>>  endif
>>  
>>  # Override our module desitnation
>> -MOD_DESTDIR = $(shell cd .. && $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
>>  MOD_TARGET = aic7xxx.o
>>  
>>  include $(TOPDIR)/Rules.make
>
>You probably should get rid of the comment before the MOD_DESTDIR too.

The MOD_TARGET still overrides the target, yet another aic7xxx kludge
because the maintainer does not want to rename the source files.

