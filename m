Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSGQVbq>; Wed, 17 Jul 2002 17:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSGQVbq>; Wed, 17 Jul 2002 17:31:46 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13828 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316755AbSGQVbq>;
	Wed, 17 Jul 2002 17:31:46 -0400
Date: Wed, 17 Jul 2002 14:33:32 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.25  uhci-hcd  very bad
Message-ID: <20020717213332.GA10227@kroah.com>
References: <3D308A30.7070702@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D308A30.7070702@wanadoo.fr>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 19 Jun 2002 20:28:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 10:14:40PM +0200, Pierre Rousselet wrote:
> usb inboard Abit BE6, ADSL modem Speedtouch usb.
> 
> I used to use satisfactorily usb-uhci-hcd before 2.5.25, switching to 
> uhci-hcd halts the adsl modem after a few minutes with this message:
> 
> kernel: uhci-hcd.c: c000: host controller process error. something bad 
> happened
> kernel: uhci-hcd.c: c000: host controller halted. very bad
> 
> 2.5.24 is not happy too with uhci-hcd.
> 
> What should I look at ?

Is this the usbfs userspace ASDL driver?  Or the kernel driver?

thanks,

greg k-h
