Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWDWG6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWDWG6A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 02:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDWG6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 02:58:00 -0400
Received: from styx.suse.cz ([82.119.242.94]:27605 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751352AbWDWG57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 02:57:59 -0400
Date: Sun, 23 Apr 2006 08:58:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Message-ID: <20060423065818.GA12611@suse.cz>
References: <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com> <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com> <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com> <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com> <20060422185402.GC10613@suse.cz> <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com> <20060422200455.GA10994@suse.cz> <305c16960604221401k4e6493b6xa9c898a92c6b028d@mail.gmail.com> <20060422215356.GA11798@suse.cz> <305c16960604221528i2407e2d5nb8aa97c011246e71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960604221528i2407e2d5nb8aa97c011246e71@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 07:28:39PM -0300, Matheus Izvekov wrote:

> > It seems to be missing something at the top, also the whitespace
> > formatting seems to be discarded - everything is aligned to the first
> > column, making it rather hard to read. Please retry using 'dmesg -s 131072'.

> Ok, fixed it, using dmesg now (had to increase the printk shift so it
> wouldnt throw things out)

Yes, this one looks much better.

The keyboard part of the device is OK, but the multimedia/mouse part is
totally FUBAR. Adding support for any keys that are not making it
through should be trivial, but making it not appear as a crazy joystick
is not realistically possible: The device insists on that it IS a device
from hell with almost all possible valuators defined in the HID spec.

-- 
Vojtech Pavlik
Director SuSE Labs
