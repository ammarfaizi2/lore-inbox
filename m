Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVJICHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVJICHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 22:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJICHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 22:07:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:22738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932071AbVJICHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 22:07:05 -0400
Date: Sat, 8 Oct 2005 09:14:41 -0700
From: Greg KH <greg@kroah.com>
To: "Ivan S. Dubrov" <WFrag@yandex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with iPaq synchronization
Message-ID: <20051008161441.GA5859@kroah.com>
References: <4347E069.000001.31814@pantene.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4347E069.000001.31814@pantene.yandex.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2005 at 07:06:17PM +0400, Ivan S. Dubrov wrote:
> Hello,
> 
> I'm trying to synchronize with my iPaq (rx3715) and get the following error
> (in dmesg):
> 
> usb 1-1: new full speed USB device using ohci_hcd and address 9
> ipaq 1-1:2.0: PocketPC PDA converter detected
> drivers/usb/serial/ipaq.c: active config #2 != 1 ??
> ipaq: probe of 1-1:2.0 failed with error -5
> 
> I have kernel 2.6.12-1-amd64-k8 from the Debian/AMD64 Etch distribution.

Does this happen when using 2.6.14-rc3?

thanks,

greg k-h
