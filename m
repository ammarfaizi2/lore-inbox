Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSHZQSC>; Mon, 26 Aug 2002 12:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSHZQSC>; Mon, 26 Aug 2002 12:18:02 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:54536 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317872AbSHZQSC>;
	Mon, 26 Aug 2002 12:18:02 -0400
Date: Mon, 26 Aug 2002 09:22:05 -0700
From: Greg KH <greg@kroah.com>
To: Luca Barbieri <ldb@ldb.ods.org>, petkan@users.sourceforge.net,
       pe1rxq@amsat.org
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020826162204.GB17819@kroah.com>
References: <1030232838.1451.99.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030232838.1451.99.camel@ldb>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 01:47:18AM +0200, Luca Barbieri wrote:
> ./drivers/usb/media/se401.h

Should be fixed, Jeroen, do you want to do this?

> ./drivers/usb/serial/whiteheat.c

False positive, those functions are never even called :)

> ./drivers/usb/net/rtl8150.c

Should be fixed, Petko want to do it?

> ./drivers/usb/host/hc_simple.h

Hm, these also need to be fixed, but there doesn't seem to be a
maintainer for the code.  I'll just take the inline marking off of them,
if no one minds.

thanks,

greg k-h
