Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTH0HKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTH0HKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:10:19 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:8637 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263183AbTH0HKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:10:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@ucw.cz>
Subject: Re: 2.6: Synaptics TouchPad and GPM (GPM patches)
Date: Wed, 27 Aug 2003 02:10:14 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200308222146.56381.dtor_core@ameritech.net> <20030826074542.GA12430@ucw.cz>
In-Reply-To: <20030826074542.GA12430@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308270210.14939.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 02:45 am, Vojtech Pavlik wrote:
> On Fri, Aug 22, 2003 at 09:46:56PM -0500, Dmitry Torokhov wrote:
> >
> > Kernel has to support EV_SYNC for touchpad and synaptics support,
> > relative and absolute modes can be used with 2.4 kernels by specifying
> > nosync option.
>
> You should not need any options for this - it's all queryable via ioctls
> ...

Done, along with implementing new type "auto" which selects best mode for 
the device.

Dmitry
