Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVEJSgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEJSgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVEJSgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:36:50 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:29921 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S261727AbVEJSgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:36:48 -0400
Date: Tue, 10 May 2005 20:36:51 +0200
To: Greg KH <gregkh@suse.de>, James Chapman <jchapman@katalix.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH] ds1337: export ds1337_do_command
Message-ID: <20050510183651.GA10720@orphique>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org> <20050510121814.GB2492@orphique> <20050510175549.GC1530@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510175549.GC1530@suse.de>
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 10:55:49AM -0700, Greg KH wrote:
> > --- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.637992600 +0200
> > +++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 14:13:05.064404656 +0200
> > @@ -380,5 +380,7 @@
> >  MODULE_DESCRIPTION("DS1337 RTC driver");
> >  MODULE_LICENSE("GPL");
> >  
> > +EXPORT_SYMBOL(ds1337_do_command);
> 
> EXPORT_SYMBOL_GPL() ok?

I do not realy care (and I think since unfamous SCO case people care
more about licenses than writing code). James is driver author, so I'll
do whatever he (and you) think is right. And while you bring up license
issue, comment on top of file says GPL version 2, but MODULE_LICENSE is
set to GPL.

Best regards,
	ladis
