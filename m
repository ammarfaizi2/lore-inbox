Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266576AbUBQXbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUBQXbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:31:21 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:18296 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266576AbUBQXaJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:30:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Emmeran Seehuber <rototor@rototor.de>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Tue, 17 Feb 2004 18:29:56 -0500
User-Agent: KMail/1.6
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <200402170118.05753.dtor_core@ameritech.net> <200402172313.39140.rototor@rototor.de>
In-Reply-To: <200402172313.39140.rototor@rototor.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402171829.57596.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 06:13 pm, Emmeran Seehuber wrote:

OK, I am lost.. how many pointing devices you physically have?
2 or 3? According to the kernel data you have 2 PS/2 devices
and one USB trackball:

> N: Name="PS2++ Logitech Mouse"
> P: Phys=isa0060/serio2/input0
> N: Name="PS/2 Generic Mouse"
> P: Phys=isa0060/serio4/input0
> N: Name="Microsoft Microsoft Trackball Explorer®"
> P: Phys=usb-0000:00:03.2-1/input0

Is this correct? Or you have only 2 devices (one PS/2 and one USB) and it
is one of those wierd USB legacy emulation troubles. Does it behave better
if you load USB modules first and only then psmouse?

-- 
Dmitry
