Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFTLQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFTLQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFTLQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:16:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34757 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261153AbVFTLNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:13:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: 2.6.12 udev hangs at boot
Date: Mon, 20 Jun 2005 14:13:22 +0300
User-Agent: KMail/1.5.4
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, Jeff Garzik <jgarzik@pobox.com>
References: <200506181332.25287.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <42B697B4.8060109@stesmi.com>
In-Reply-To: <42B697B4.8060109@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201413.22471.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 13:17, Stefan Smietanowski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Denis.
> 
> > After all, udev is tied to /sys layout which changes with kernel
> > and also udev is vital for properly functioning boot process
> 
> Not if you use a static /dev.

Static /dev kind of defeats the purpose of udev.
I do not want to go back to the days when I had tons of
/dev/{h,s}d{a,b,c,d,e,f}{0,1,2,3,4,5,6,7,8,9} for every
IDE and SCSI block device possible. Same for /dev/tty*.
I want them appear on the fly, if/when hardware is present.
--
vda

