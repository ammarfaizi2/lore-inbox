Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUFJJ7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUFJJ7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUFJJ7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:59:52 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:20169 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264206AbUFJJ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:59:49 -0400
Subject: Re: oops on checking for changes of usb input devices
From: Soeren Sonnenburg <kernel@nn7.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200406100200.50146.dtor_core@ameritech.net>
References: <1086847579.24322.34.camel@localhost>
	 <200406100200.50146.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1086861583.5204.6.camel@localhost>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 11:59:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-10 at 09:00, Dmitry Torokhov wrote:
> On Thursday 10 June 2004 01:06 am, Soeren Sonnenburg wrote:
> > 
> > Hi!
> > 
> > When I attach a ps2 mouse and keyboard through a ps2->usb adapter and
> > then do a rescan for changes in input devices I keep getting this oops.
> > This is kernel 2.6.7-rc2 on powerbook G4. A way to trigger this is to
> > reload/restart pbbuttonsd.
> > 
> > Any ideas ?
> 
> I think it has been fixed in -rc3.


I can confirm this. I (de-)attached the ps2 keyboard + usb mouse a
couple of times and triggered a pbbuttonsd rescan... no oops no nothing
:)

Great job!

Soeren (happy)

