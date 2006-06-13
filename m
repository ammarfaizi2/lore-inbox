Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWFMVak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWFMVak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFMVak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:30:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:30968 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932245AbWFMVaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:39 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Date: Tue, 13 Jun 2006 23:30:24 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de> <200606121934.05619.o.bock@fh-wolfenbuettel.de> <20060613192304.GG27312@elf.ucw.cz>
In-Reply-To: <20060613192304.GG27312@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606132330.24677.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > Hm, the chipset family is just called like that and there're at least
> > three other Cypress related drivers (cypress, cypress_m8 and cytherm)
> > with generic names. I think this name shows clearly what kind of device
> > it supports, doesn't it?
>
> cypress_63 might be unique and still easier to pronounce?

Hm, what about something related to the vendor "AK Modul-Bus Computer GmbH"?
I think my driver might (!) only work for their firmware implementations...

cypress_akmb
cypress_akmodbus
cypress_akmodulbus

The third would be my favourite. Are there any length restrictions for 
driver/files names? Is it a problem to use parts of company names for this 
purpose (I saw lego, rio, auerswald, etc.) or does one need to ask them for 
permission in this case?

> > You mean the whole string (line) one character to the right, correct?
>
> Yes. It should be
>
> foo(BAR,
>     BAZ).
>
> (You have it at few more places).

I changed it. I had the rule "only tabs for indentation" on my mind and tried 
to choose the closest ;-) Now I first use tabs followed by spaces for 
fine-tuning (if needed).

What about the macro discussion?
If there's any convention I'm happy to follow it...


Thanks,
Oliver

