Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbUJ1H4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUJ1H4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbUJ1H4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:56:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22284 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262815AbUJ1H4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:56:11 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Nigel Kukard <nkukard@lbsd.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Date: Thu, 28 Oct 2004 10:55:47 +0300
User-Agent: KMail/1.5.4
References: <41809921.10200@lbsd.net>
In-Reply-To: <41809921.10200@lbsd.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281055.47263.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 10:00, Nigel Kukard wrote:
> I just got the below oops when i mounted a usb camera's SD-Card.
> 
> Could anyone share some light on the issue?
> 
> -Nigel
> 
> 
> ------------[ cut here ]------------
> kernel BUG at fs/fat/cache.c:150!
> invalid operand: 0000 [#1]
> PREEMPT SMP
> Modules linked in: smbfs autofs4 nls_cp437 msdos fat nfsd exportfs lockd 
> sunrpc tsdev uhci_hcd parport_pc parport eth1394 nvidia ohci1394 
                                                   ^^^^^^
> ieee1394 usbmouse usbkbd usbhid ehci_hcd ub ohci_hcd usbcore i2c_sis96x 
> i2c_core pci_hotplug sis_agp agpgart evdev sis900 crc32 snd_als4000 
> snd_sb_common snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep 
> snd_mpu401_uart snd_rawmidi snd_seq_device snd
> CPU:    0
> EIP:    0060:[<f8cec268>]    Tainted: P      VLI
                               ^^^^^^^^^^

Try to reproduce without it and/or
contact nvidia on the issue
--
vda

