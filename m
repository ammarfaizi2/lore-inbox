Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSJUOuq>; Mon, 21 Oct 2002 10:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSJUOup>; Mon, 21 Oct 2002 10:50:45 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30984 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261495AbSJUOuo>;
	Mon, 21 Oct 2002 10:50:44 -0400
Date: Mon, 21 Oct 2002 07:55:48 -0700
From: Greg KH <greg@kroah.com>
To: Peter <pk@q-leap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops still occurs with usb-serial converter
Message-ID: <20021021145548.GA30857@kroah.com>
References: <S.0001127744@wolnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S.0001127744@wolnet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 12:02:38PM +0200, Peter wrote:
> Hello,
> 
> The attached kernel oops still occurs (was reported with kernel 2.4.19
> on July, 29th):
> 
> Hardware:
>   Dell Inspiron 2600 Laptop
>   USB-Serial Converter: UC-232A
> 
> Software:
>   minicom (V1.82.1)
>   kernel: 2.4.20-pre11
> 
> modules loaded:
> pl2303                 10104   1
> usbserial              17468   0 [pl2303]
> uhci                   23600   0 (unused)

Does the same problem happen with usb-uhci instead of uhci?

thanks,

greg k-h
