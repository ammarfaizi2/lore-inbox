Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424093AbWLBOED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424093AbWLBOED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 09:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424098AbWLBOED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 09:04:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57067 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424093AbWLBOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 09:04:00 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com>
Date: Sat, 02 Dec 2006 07:02:57 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Fri, 1 Dec 2006 18:43:03 -0800")
Message-ID: <m1irgufl9q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Thanks for the code.
>
> In LinuxBIOS,
> I put usbdevice_direct.c in lib/, and call it from usb2_init in
> mcp55_usb2.c
>
> Got 
> "No device in debug port"
>
> Waiting for cable, hope to get that cable next Tuesday.
>
> Will create usbdebug_direct_console.c in console/ for linuxbios_ram
> code.
> also usbdebug_direct_serial.c in pc80/ for cache_as_ram.c


Please yank the direct out of the filename if you are making something
like this out of it.  That was my note I was going direct to hardware
which is pretty much assumed if you are in LinuxBIOS.

Eric
