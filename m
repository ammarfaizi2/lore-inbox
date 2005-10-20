Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVJTXIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVJTXIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVJTXIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:08:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:15813 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964801AbVJTXIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:08:13 -0400
Message-ID: <4a45da430510201607x78c5e432r5d641c46dd15eeaa@mail.google.com>
Date: Thu, 20 Oct 2005 16:07:59 -0700
From: Jonathan Mayer <jonmayer@google.com>
To: dtor_core@ameritech.net
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <d120d5000510201603n50c068dcyade2ce2cfd2311e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
	 <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com>
	 <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com>
	 <d120d5000510201603n50c068dcyade2ce2cfd2311e0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it is a device it goes onto corresponding bus. Platform bus is a
> kind of a kitchen sink for things that do not have a "real" bus -
> things like keyboard controller, older ISA devices, etc. Only things
> that necessary to get the box going and have to be suspended last with
> interrupts off (like IRQ controller) should be implemented as system
> devices.

I see!  Okay, I will make this so.  Thanks for the explanation.

Even so, I still think my patch is a good idea (for the sysdev
attributes, and all kobject attribute derived thingies in general).

 - Jonathan.
