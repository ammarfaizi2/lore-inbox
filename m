Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVI0PUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVI0PUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVI0PUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:20:00 -0400
Received: from [85.21.88.2] ([85.21.88.2]:62354 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964929AbVI0PT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:19:59 -0400
Subject: Re: [spi-devel-general] Re: SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <20050927145442.GA27470@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
	 <20050927124335.GA10361@kroah.com>
	 <1127831236.7577.33.camel@diimka.dev.rtsoft.ru>
	 <20050927143505.GA24245@kroah.com>
	 <1127832597.7577.37.camel@diimka.dev.rtsoft.ru>
	 <20050927145442.GA27470@kroah.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 19:19:57 +0400
Message-Id: <1127834397.7577.42.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 07:54 -0700, Greg KH wrote:
> Not good, reference counted structures almost always should be
> dynamically created.  Please change this to also be true for SPI,
> otherwise you will have a lot of nasty issues with devices that can be
> removed at any point in time.
Hmm. I thought a bit about this and it seems reasonable. I'll change
this to dynamic allocation. 

> thanks,
> 
> greg k-h

