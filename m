Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWEQONd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWEQONd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWEQONd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:13:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932566AbWEQONd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:13:33 -0400
Date: Wed, 17 May 2006 10:13:07 -0400
From: Alan Cox <alan@redhat.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Alan Cox <alan@redhat.com>, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       "'Mauro Carvalho Chehab'" <mchehab@infradead.org>,
       v4l-dvb-maintainer@linuxtv.org, mdharm-usb@one-eyed-alien.net
Subject: Re: [usb-storage] Re: [v4l-dvb-maintainer] 2.6.16-rc: saa7134 + u sb-storage = freeze
Message-ID: <20060517141307.GB23095@devserv.devel.redhat.com>
References: <820212CF2FD63647B52A8F64B35352B20B942298@essomaexc1.essvote.com> <20060315234421.GB4414@devserv.devel.redhat.com> <20060315234918.GJ4454@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315234918.GJ4454@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 12:49:18AM +0100, Adrian Bunk wrote:
> > A lot of this is BIOS dependant and if we can isolate cases where one
> > BIOS works and another doesn't an lspci -vvxxx would be helpful so we
> > can look for chipset pokery
> 
> It's below.

Vendor fix went to the ide maintainer and to me for the libata ALi driver
so ATA/ATAPI should all work now. Not clear if that also fixes the non IDE
cases but would be useful to know

