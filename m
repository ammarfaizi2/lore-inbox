Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932989AbWFWKUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbWFWKUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWFWKUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:20:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:24123 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932989AbWFWKUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:20:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bzpvNKaPIiknE6lJrm1B7QfHe3XkUeeVZ271AIC7BQV6RPtX+4RjI7LaX6YG0mlDg6nyeXza2D9AHaG4mJZyy9FB1KbjAlzCVjT9NqRCPbxNjedu3AkrzeblO6WhGg5/49C6XBoGOz4fneUcdDYQtNkkkSvZNhK4VhqEy715eDg=
Message-ID: <e6ec3ad10606230320s25596353y7b238593b90051f5@mail.gmail.com>
Date: Fri, 23 Jun 2006 12:20:05 +0200
From: "Marcin Juszkiewicz" <openembedded@hrw.one.pl>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: sharp zaurus sl-5500 (collie): touchscreen now works
Cc: "Pavel Machek" <pavel@suse.cz>, lenz@cs.wisc.edu,
       "kernel list" <linux-kernel@vger.kernel.org>, metan@seznam.cz,
       arminlitzel@web.de
In-Reply-To: <1150329342.9240.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060610202541.GA26697@elf.ucw.cz>
	 <1150139307.5376.56.camel@localhost.localdomain>
	 <20060614232814.GJ7751@elf.ucw.cz>
	 <1150329342.9240.38.camel@localhost.localdomain>
X-Google-Sender-Auth: a43357562821360a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday someone added following info into OpenZaurus FAQ [1]:

> Zaurus SL-5500 MMC/SDIO technical info
>
> For communicating with the MMC/SDIO card SL-5500 uses the LoCoMo built-in
> SPI controller (secondary communication protocol) and 3 LoCoMo GPIOs
>
> LOCOMO_SPIMD for SPI MODE
> LOCOMO_SPICT for SPI CONTROL
> LOCOMO_SPIST for SPI STATUS
> LOCOMO_SPITD for SPI TRANSMIT (write)
> LOCOMO_SPIRD for SPI RECEIVE (read)
>
> LOCOMO_GPIO(13) for MMC irq / card detect
> LOCOMO_GPIO(14) for MMC write protect test bit
> LOCOMO_GPIO(15) for MMC power
>
> All these registers are 16bit, and data transfers are 8bit. On resume
> the SPI MODE is set to 0x6c14, on suspend to 0x3c14.
>
> Useful bits in the SPI MODE register: 0x0001, 0x0040, 0x0080.
> Useful bits in the SPI CONTROL register: 0x0040 and 0x0080.
>
> For further information read the Sandisk SD card manual. A software
> implementation of the SPI MMC/SD protocol driver can be be found at
> http://kiel.kool.dk/mmc.c

Maybe this will help.

1. http://openzaurus.berlios.de/FAQ
