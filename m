Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264679AbUD1HW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbUD1HW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbUD1HW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:22:27 -0400
Received: from [194.89.250.117] ([194.89.250.117]:59545 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S264679AbUD1HWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:22:25 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Date: Wed, 28 Apr 2004 10:22:23 +0300
User-Agent: KMail/1.6.1
References: <40853060.2060508@bigfoot.com> <408EF33F.5040104@bigfoot.com> <1083136394.23415.4.camel@amilo.bradney.info>
In-Reply-To: <1083136394.23415.4.camel@amilo.bradney.info>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404281022.23878.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 10:13, Craig Bradney wrote:

> > >>>  the mouse says: Cordless MouseMan Wheel (Logitech), it has
> > >>> left/right buttonss, wheel that can be pushed or rotated and a side
> > >>> button, not sure how to better identify it. With 2.4 kernels it used
> > >>> to work with X using protocol MouseManPlusPS/2.
> > >>
> > >>   anybody? any hints? should I look at driver? are there some docs for
> > >>logitech mice (protocol)?
> > >
> > > err.. they all Just Work (tm) here.. ps2 or USB, IMPS/2 driver
> >
> >    which kernel (mine doesn't work with 2.6.5, used to work with 2.4.x),
> > which mouse models? I guess there might be more models and for some
> > reason my particular model does not work. Can you find out which
> > protocol the kernel is using (psmouse, not usb)?
>
> 2.4.x, 2.61,3,5, currently 2.6.5 on 4 PCs
>
> -logitech cordless optical for notebooks (USB)
> -logitech cordless mouseman optical (via a kmv switch to 2PCs )(ps2)
> -logitech cordless optical mouse(ps2)
>
> err. how do i find out the protocol the kernel uses?

Check your kernel logs (/var/log/messages perhaps). Grepping for "psmouse" 
will help you find the relevant part.




Kim
