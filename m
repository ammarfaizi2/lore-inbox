Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSLQWD2>; Tue, 17 Dec 2002 17:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSLQWD2>; Tue, 17 Dec 2002 17:03:28 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:10184 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267083AbSLQWD1>; Tue, 17 Dec 2002 17:03:27 -0500
Date: Tue, 17 Dec 2002 15:04:00 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Anders Fugmann <afu@fugmann.dhs.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: mousewheel not working.
In-Reply-To: <3DFF070A.6010804@fugmann.dhs.org>
Message-ID: <Pine.LNX.4.33.0212171503430.1879-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm having troubles getting the mosuewheel on my logitech ps/2 mouseman+
> (model M-C48) to work, under 2.5.52. Do I need to add something special
> to the kernel boot parameters to instruct the driver that my mouse
> carries 5 buttons?
>
> dmesg:
> device class 'input': registering
> register interface 'mouse' with class 'input'
> mice: PS/2 mouse device common for all mice
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
>
> .config
>
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set

Did you enable SERIO_8042 support ?


