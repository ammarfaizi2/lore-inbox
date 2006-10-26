Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422985AbWJZLtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWJZLtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422942AbWJZLtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:49:55 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:40925 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161144AbWJZLty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:49:54 -0400
Subject: Re: usb initialization order (usbhid vs. appletouch)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200610261220.05707.oliver@neukum.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	 <200610261220.05707.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 13:49:40 +0200
Message-Id: <1161863380.18657.38.camel@no.intranet.wo.rk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 12:20 +0200, Oliver Neukum wrote:
> Am Donnerstag, 26. Oktober 2006 11:53 schrieb Soeren Sonnenburg:
> > Dear all,
> > 
> > I've noticed that the appletouch driver needs to be loaded *before* the
> > usbhid driver to function. This is currently impossible when built into
> > the kernel (and not modules). So I wonder how one can change the
> > ordering of when the usb drivers are loaded.
> > 
> > Suggestions ?
> 
> Add a quirk to HID. Messing around with probing orders is not
> a sure thing.

what do you have in mind ? if appletouch is turned on ignore IDs that
appear in appletouch ?

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
