Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUHRGmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUHRGmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUHRGmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:42:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:47522 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261159AbUHRGma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:42:30 -0400
Date: Wed, 18 Aug 2004 08:42:29 +0200
From: Olaf Hering <olh@suse.de>
To: ismail =?utf-8?Q?d=C3=B6nmez?= <ismail.donmez@gmail.com>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Message-ID: <20040818064229.GD22332@suse.de>
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com> <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de> <2a4f155d040817233463d2b78d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4f155d040817233463d2b78d@mail.gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Aug 18, ismail dönmez wrote:

> On Wed, 18 Aug 2004 08:22:10 +0200, Olaf Hering <olh@suse.de> wrote: 
> > /dev/tty is supposed to be char c 5 0, /class/tty/tty/dev will tell udev
> > how to create it, see man 4 tty.
> > No idea who came up with the bright idea to put legacy bsd devices in a
> > subdir. Documentation/devices.txt shows that my patch is ok, it handles
> > up to 256 device nodes.
> > If you are using udev, file a bugreport for your distros package. In the
> > meantime, remove the offending line from your udev.rules file.
> 
> I don't think you understood me. /dev/tty is created as a char device
> in 2.6.8.1 kernel. So I am sure udev is fine but it shows up as a
> directory in 2.6.8.1-mm1 kernel and if I backup bk-driver-core.patch
> its all normal again.

Works fine here.
Check you udev.rules file if some rule matches the pattern ptyp0.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
