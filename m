Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262361AbSJODoT>; Mon, 14 Oct 2002 23:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSJODoT>; Mon, 14 Oct 2002 23:44:19 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14343 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262361AbSJODoT>;
	Mon, 14 Oct 2002 23:44:19 -0400
Date: Mon, 14 Oct 2002 20:50:19 -0700
From: Greg KH <greg@kroah.com>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "sleeping function called ... " on modprobe uhci-hcd
Message-ID: <20021015035019.GA10925@kroah.com>
References: <20021014214934.35069015.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014214934.35069015.arashi@arashi.yi.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 09:49:34PM -0500, Matt Reppert wrote:
> Debug: sleeping function called from illegal context at include/asm/semaphore.h:126
> Call Trace:
>  [<c0114054>] __might_sleep+0x54/0x60
>  [<c01f46ad>] usb_hub_events+0x65/0x2b8

This is fixed in Linus's tree.

thanks,

greg k-h
