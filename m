Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWGCKER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWGCKER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWGCKER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:04:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:39449 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751068AbWGCKEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:04:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GczSwx81eCWkJjKO+XT143NRHjDhgD6dZpiZ2wtIxyIGmMMgdVOrNb7TaKp6DmruE4BSo8hxsUNMw5t2ZrM4kstQhk/8vUBow0yS6g8I43cixTVJ8P++s7kXw+NLvGwnxI3I+741QlzdMAT4xE7YKyEul4Au0zgbvU2eFrVYrRI=
Message-ID: <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
Date: Mon, 3 Jul 2006 13:04:14 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/06, Daniel Bonekeeper <thehazard@gmail.com> wrote:
> Hello everybody.
>
> I would like to develop a driver for any kind of fingerprint reader
> that currently doesn't have a driver for linux, and I'm open for
> suggestions on which device I should use. My first thought was the
> microsoft usb fingerprint reader
> (http://www.geeks.com/details.asp?invtid=DG2-00002-DT&cpc=SCH) because
> it's a new device (and, of course, doesn't have any driver for linux),
> it's cheap, and it's from MS (read "would be fun" =)

Please consider UPEK reader.
It is available on all new Thinkpad laptops, and the vendor provides
only binary drivers.

http://www.upek.com/support/dl_linux_bsp.asp

I hate when vendors like ATI, Conexant and UPEK publish binary drivers
without publishing the chipset spec... They should decide whether
their IP is on the software part or on the hardware part, if it is on
the hardware part, they are making money in selling the hardware. If
it is on the software part, there is no reason why not providing the
information for others to write software to work with the primitive
hardware. So in either case there should be full hardware interface
disclosure.

Best Regards and Goodluck!
Alon Bar-Lev.
