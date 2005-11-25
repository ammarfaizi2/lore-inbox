Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVKYNxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKYNxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVKYNxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:53:25 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:10429 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932265AbVKYNxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:53:25 -0500
Date: Fri, 25 Nov 2005 14:53:33 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Marc Koschewski <marc@osknowledge.org>, Ed Tomlinson <tomlins@cam.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Message-ID: <20051125135332.GC6728@stiffy.osknowledge.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511240717.11752.tomlins@cam.org> <20051124124444.GA23667@stiffy.osknowledge.org> <200511242124.00127.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511242124.00127.rjw@sisk.pl>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl> [2005-11-24 21:23:59 +0100]:

> On Thursday, 24 of November 2005 13:44, Marc Koschewski wrote:
> }-- snip --{
> > > It looks like you are seeing a different bug.  The one opened for debian user space
> > > covers mousedev not being loaded if the kernel is 2.6.15, which leads to no /dev/input
> > > 
> > 
> > That's what I think, thus the report on LKLM. But noone but me seems to
> > be trapped into it until... :/
> 
> FWIW, my touchpad doesn't work with -rc2-mm1 too (usually I use a USB mouse,
> so I didn't notice before).  Here's what dmesg says about it:
> 
> Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
> input: SynPS/2 Synaptics TouchPad as /class/input/input2
> 
> The box is an Asus L5D (x86-64).

That's what 2.6.15-rc2 reports for my input devices:

stiffy:/var/cache/apt/archives# dmesg | grep input
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver

Regards,
	Marc
