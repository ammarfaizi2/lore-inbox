Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTH0MbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTH0MbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:31:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:5530 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263335AbTH0MbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:31:05 -0400
Date: Wed, 27 Aug 2003 14:30:55 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: Synaptics TouchPad and GPM (GPM patches)
Message-ID: <20030827123055.GA25720@ucw.cz>
References: <200308222146.56381.dtor_core@ameritech.net> <20030826074542.GA12430@ucw.cz> <200308270210.14939.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308270210.14939.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 02:10:14AM -0500, Dmitry Torokhov wrote:

> On Tuesday 26 August 2003 02:45 am, Vojtech Pavlik wrote:
> > On Fri, Aug 22, 2003 at 09:46:56PM -0500, Dmitry Torokhov wrote:
> > >
> > > Kernel has to support EV_SYNC for touchpad and synaptics support,
> > > relative and absolute modes can be used with 2.4 kernels by specifying
> > > nosync option.
> >
> > You should not need any options for this - it's all queryable via ioctls
> > ...
> 
> Done, along with implementing new type "auto" which selects best mode for 
> the device.

Cool.

You could even make it search for all mouse-like input devices ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
