Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSJVOa5>; Tue, 22 Oct 2002 10:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbSJVOa5>; Tue, 22 Oct 2002 10:30:57 -0400
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:46496 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S262808AbSJVOaz>; Tue, 22 Oct 2002 10:30:55 -0400
Message-Id: <200210221428.QAA75603@delphin.mathe.tu-freiberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: Take Vos <Take.Vos@binary-magic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: PS/2 keyboard and mouse not available/working/weird
Date: Tue, 22 Oct 2002 16:37:47 +0200
X-Mailer: KMail [version 1.3.2]
References: <200210221603.54816.Take.Vos@binary-magic.com>
In-Reply-To: <200210221603.54816.Take.Vos@binary-magic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. Oktober 2002 16:03 schrieb Take Vos:

> Hello,
>
> kernel: linux-2.5.44

I have a similar problem.

> config:
>                 CONFIG_INPUT_MOUSEDEV
>                 CONFIG_INPUT_EVDEV
>                 CONFIG_SERIO
>                 CONFIG_SERIO_I8042
>                 CONFIG_INPUT_MOUSE
>                 CONFIG_MOUSE_PS2
>                 CONFIG_USB
>                 CONFIG_USB_HID
>                 CONFIG_USB_HIDINPUT


My .config is

CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y



CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD_ALT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y




>
> In 2.5.44 both my PS/2 mice are not available, neither is my keyboard,
> although after sufficient keystrokes, sometimes 5, sometimes more, the
> keyboard is found, this is with Xfree.

Toggling CapsLock etc. does nothing to the LEDs. I can move the Mousepointer
around with the PS/2 mouse, but I can not click. My USB mouse sort of works, 
but only in one USB connector. Not the other. 

The box is a Sony Vaio Picturebook (japanese version). This was working in 
2.5.42.

If you need more info, just ask.

Michael


