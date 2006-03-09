Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWCIUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCIUal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCIUal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:30:41 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:55942 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751402AbWCIUak convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:30:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L8tS+cZAoJWPngjqsiGEUKHrd8IQyIMJoMgVfkrMDwtDY3nLKhXyJIUHhXTYpwHOUM6dmQIXpxTJnUMufKxNhafqPyt7yWux655vPBzqw310oBUEoGYAYNtQu9fL5RrbvkY5h9Wt/ekX3kY2+TX/PxLfWu7xqkwYuX2fJXeNu9I=
Message-ID: <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com>
Date: Thu, 9 Mar 2006 17:30:38 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
	 <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
	 <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
	 <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com>
	 <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> No, not really. atkbd is a recommended (and only) driver when
> connecting PS/2 keyboards. We do want user to know how to set up
> additional keys, if any. usbkbd driver is only to be used when there
> are issues with full HID driver. It will only provide "standard" keys
> and is not expected to be modified.
>
> --
> Dmitry
>

Did that. keyboard in question here is a Microsoft Wireless Comfort
Keyboard 1.0A + Wireless Optical Mouse 2.0. they share the same
receiver, and it supports low battery and weak signal status for both
the mouse and the keyboard. Here is the output of those debug messages
in hid-input:

Mapping: Keyboard.00a4 ---> Key.Unknown
Mapping: Keyboard.00a5 ---> Key.Unknown
Mapping: Keyboard.00a6 ---> Key.Unknown
Mapping: Keyboard.00a7 ---> Key.Unknown
Mapping: Keyboard.00a8 ---> Key.Unknown
Mapping: Keyboard.00a9 ---> Key.Unknown
Mapping: Keyboard.00aa ---> Key.Unknown
Mapping: Keyboard.00ab ---> Key.Unknown
Mapping: Keyboard.00ac ---> Key.Unknown
Mapping: Keyboard.00ad ---> Key.Unknown
Mapping: Keyboard.00ae ---> Key.Unknown
Mapping: Keyboard.00af ---> Key.Unknown
Mapping: Keyboard.00b0 ---> Key.Unknown
Mapping: Keyboard.00b1 ---> Key.Unknown
Mapping: Keyboard.00b2 ---> Key.Unknown
Mapping: Keyboard.00b3 ---> Key.Unknown
Mapping: Keyboard.00b4 ---> Key.Unknown
Mapping: Keyboard.00b5 ---> Key.Unknown
Mapping: Keyboard.00b6 ---> Key.Unknown
Mapping: Keyboard.00b7 ---> Key.Unknown
Mapping: Keyboard.00b8 ---> Key.Unknown
Mapping: Keyboard.00b9 ---> Key.Unknown
Mapping: Keyboard.00ba ---> Key.Unknown
Mapping: Keyboard.00bb ---> Key.Unknown
Mapping: Keyboard.00bc ---> Key.Unknown
Mapping: Keyboard.00bd ---> Key.Unknown
Mapping: Keyboard.00be ---> Key.Unknown
Mapping: Keyboard.00bf ---> Key.Unknown
Mapping: Keyboard.00c0 ---> Key.Unknown
Mapping: Keyboard.00c1 ---> Key.Unknown
Mapping: Keyboard.00c2 ---> Key.Unknown
Mapping: Keyboard.00c3 ---> Key.Unknown
Mapping: Keyboard.00c4 ---> Key.Unknown
Mapping: Keyboard.00c5 ---> Key.Unknown
Mapping: Keyboard.00c6 ---> Key.Unknown
Mapping: Keyboard.00c7 ---> Key.Unknown
Mapping: Keyboard.00c8 ---> Key.Unknown
Mapping: Keyboard.00c9 ---> Key.Unknown
Mapping: Keyboard.00ca ---> Key.Unknown
Mapping: Keyboard.00cb ---> Key.Unknown
Mapping: Keyboard.00cc ---> Key.Unknown
Mapping: Keyboard.00cd ---> Key.Unknown
Mapping: Keyboard.00ce ---> Key.Unknown
Mapping: Keyboard.00cf ---> Key.Unknown
Mapping: Keyboard.00d0 ---> Key.Unknown
Mapping: Keyboard.00d1 ---> Key.Unknown
Mapping: Keyboard.00d2 ---> Key.Unknown
Mapping: Keyboard.00d3 ---> Key.Unknown
Mapping: Keyboard.00d4 ---> Key.Unknown
Mapping: Keyboard.00d5 ---> Key.Unknown
Mapping: Keyboard.00d6 ---> Key.Unknown
Mapping: Keyboard.00d7 ---> Key.Unknown
Mapping: Keyboard.00d8 ---> Key.Unknown
Mapping: Keyboard.00d9 ---> Key.Unknown
Mapping: Keyboard.00da ---> Key.Unknown
Mapping: Keyboard.00db ---> Key.Unknown
Mapping: Keyboard.00dc ---> Key.Unknown
Mapping: Keyboard.00dd ---> Key.Unknown
Mapping: Keyboard.00de ---> Key.Unknown
Mapping: Keyboard.00df ---> Key.Unknown
Mapping: Keyboard.00e0 ---> Key.LeftControl
Mapping: Keyboard.00e1 ---> Key.LeftShift
Mapping: Keyboard.00e2 ---> Key.LeftAlt
Mapping: Keyboard.00e3 ---> Key.LeftMeta
Mapping: Keyboard.00e4 ---> Key.RightCtrl
Mapping: Keyboard.00e5 ---> Key.RightShift
Mapping: Keyboard.00e6 ---> Key.RightAlt
Mapping: Keyboard.00e7 ---> Key.RightMeta
Mapping: Keyboard.00e8 ---> Key.PlayPause
Mapping: Keyboard.00e9 ---> Key.StopCD
Mapping: Keyboard.00ea ---> Key.PreviousSong
Mapping: Keyboard.00eb ---> Key.NextSong
Mapping: Keyboard.00ec ---> Key.EjectCD
Mapping: Keyboard.00ed ---> Key.VolumeUp
Mapping: Keyboard.00ee ---> Key.VolumeDown
Mapping: Keyboard.00ef ---> Key.Mute
Mapping: Keyboard.00f0 ---> Key.WWW
Mapping: Keyboard.00f1 ---> Key.Back
Mapping: Keyboard.00f2 ---> Key.Forward
Mapping: Keyboard.00f3 ---> Key.Stop
Mapping: Keyboard.00f4 ---> Key.Find
Mapping: Keyboard.00f5 ---> Key.ScrollUp
Mapping: Keyboard.00f6 ---> Key.ScrollDown
Mapping: Keyboard.00f7 ---> Key.Edit
Mapping: Keyboard.00f8 ---> Key.Sleep
Mapping: Keyboard.00f9 ---> Key.Coffee
Mapping: Keyboard.00fa ---> Key.Refresh
Mapping: Keyboard.00fb ---> Key.Calc
Mapping: Keyboard.00fc ---> Key.Unknown
Mapping: Keyboard.00fd ---> Key.Unknown
Mapping: Keyboard.00fe ---> Key.Unknown
Mapping: Keyboard.00ff ---> Key.Unknown
Mapping: ff00.ff0e ---> IGNORED
Mapping: ff00.fe03 ---> IGNORED
Mapping: ff00.fe04 ---> IGNORED
Mapping: ff00.ff05 ---> IGNORED
Mapping: ff00.fd01 ---> IGNORED
Mapping: ff00.fd02 ---> IGNORED
Mapping: ff00.fd03 ---> IGNORED
Mapping: ff00.fd04 ---> IGNORED
Mapping: ff00.fd05 ---> IGNORED
Mapping: ff00.fd06 ---> IGNORED
Mapping: ff00.fd07 ---> IGNORED
Mapping: ff00.fd08 ---> IGNORED
Mapping: ff00.fd09 ---> IGNORED
Mapping: ff00.fd0a ---> IGNORED
Mapping: ff00.fd0b ---> IGNORED
Mapping: ff00.fd0c ---> IGNORED
Mapping: ff00.fd0d ---> IGNORED
Mapping: ff00.fd0e ---> IGNORED
Mapping: ff00.fd0f ---> IGNORED
Mapping: ff00.fd10 ---> IGNORED
Mapping: ff00.fd11 ---> IGNORED
Mapping: ff00.fd12 ---> IGNORED
Mapping: ff00.fd13 ---> IGNORED
Mapping: ff00.fd14 ---> IGNORED
Mapping: ff00.fd15 ---> IGNORED
Mapping: ff00.fd16 ---> IGNORED
Mapping: ff00.fd17 ---> IGNORED
Mapping: ff00.fd18 ---> IGNORED
Mapping: ff00.fd19 ---> IGNORED
Mapping: ff00.fd1a ---> IGNORED
Mapping: ff00.fd1b ---> IGNORED
Mapping: ff00.fd1c ---> IGNORED
Mapping: ff00.fd1d ---> IGNORED
Mapping: ff00.fd1e ---> IGNORED
Mapping: ff00.fd1f ---> IGNORED
Mapping: ff00.fd20 ---> IGNORED
Mapping: ff00.fd21 ---> IGNORED
Mapping: ff00.fd22 ---> IGNORED
Mapping: ff00.fd23 ---> IGNORED
Mapping: ff00.fd24 ---> IGNORED
Mapping: ff00.fd25 ---> IGNORED
Mapping: ff00.fd26 ---> IGNORED
Mapping: ff00.fd27 ---> IGNORED
Mapping: ff00.fd28 ---> IGNORED
Mapping: ff00.fd29 ---> IGNORED
Mapping: ff00.fd2a ---> IGNORED
Mapping: ff00.fd2b ---> IGNORED
Mapping: ff00.fd2c ---> IGNORED
Mapping: ff00.fd2d ---> IGNORED
Mapping: ff00.fd2e ---> IGNORED
Mapping: ff00.fd2f ---> IGNORED
Mapping: ff00.fd30 ---> IGNORED
Mapping: ff00.fd31 ---> IGNORED
Mapping: ff00.fd32 ---> IGNORED
Mapping: ff00.fd33 ---> IGNORED
Mapping: ff00.fd34 ---> IGNORED
Mapping: ff00.fd35 ---> IGNORED
Mapping: ff00.fd36 ---> IGNORED
Mapping: ff00.fd37 ---> IGNORED
Mapping: ff00.fd38 ---> IGNORED
Mapping: ff00.fd39 ---> IGNORED
Mapping: ff00.fd3a ---> IGNORED
Mapping: ff00.fd3b ---> IGNORED
Mapping: ff00.fd3c ---> IGNORED
Mapping: ff00.fd3d ---> IGNORED
Mapping: ff00.fd3e ---> IGNORED
Mapping: ff00.fd3f ---> IGNORED
Mapping: ff00.fd40 ---> IGNORED
Mapping: ff00.fd41 ---> IGNORED
Mapping: ff00.fd42 ---> IGNORED
Mapping: ff00.fd43 ---> IGNORED
Mapping: ff00.fd44 ---> IGNORED
Mapping: ff00.fd45 ---> IGNORED
Mapping: ff00.fd46 ---> IGNORED
Mapping: ff00.fd47 ---> IGNORED
Mapping: ff00.fd48 ---> IGNORED
Mapping: ff00.fd49 ---> IGNORED
Mapping: ff00.fd4a ---> IGNORED
Mapping: ff00.fd4b ---> IGNORED
Mapping: ff00.fd4c ---> IGNORED
Mapping: ff00.fd4d ---> IGNORED
Mapping: ff00.fd4e ---> IGNORED
Mapping: ff00.fd4f ---> IGNORED
Mapping: ff00.fd50 ---> IGNORED
Mapping: ff00.fd51 ---> IGNORED
Mapping: ff00.fd52 ---> IGNORED
Mapping: ff00.fd53 ---> IGNORED
Mapping: ff00.fd54 ---> IGNORED
Mapping: ff00.fd55 ---> IGNORED
Mapping: ff00.fd56 ---> IGNORED
Mapping: ff00.fd57 ---> IGNORED
Mapping: ff00.fd58 ---> IGNORED
Mapping: ff00.fd59 ---> IGNORED
Mapping: ff00.fd5a ---> IGNORED
Mapping: ff00.fd5b ---> IGNORED
Mapping: ff00.fd5c ---> IGNORED
Mapping: ff00.fd5d ---> IGNORED
Mapping: ff00.fd5e ---> IGNORED
Mapping: ff00.fd5f ---> IGNORED
Mapping: ff00.fd60 ---> IGNORED
Mapping: ff00.fd61 ---> IGNORED
Mapping: ff00.fd62 ---> IGNORED
Mapping: ff00.fd63 ---> IGNORED
Mapping: ff00.fd64 ---> IGNORED
Mapping: ff00.fd65 ---> IGNORED
Mapping: ff00.fd66 ---> IGNORED
Mapping: ff00.fd67 ---> IGNORED
Mapping: ff00.fd68 ---> IGNORED
Mapping: ff00.fd69 ---> IGNORED
Mapping: ff00.fd6a ---> IGNORED
Mapping: ff00.fd6b ---> IGNORED
Mapping: ff00.fd6c ---> IGNORED
Mapping: ff00.fd6d ---> IGNORED
Mapping: ff00.fd6e ---> IGNORED
Mapping: ff00.fd6f ---> IGNORED
Mapping: ff00.fd70 ---> IGNORED
Mapping: ff00.fd71 ---> IGNORED
Mapping: ff00.fd72 ---> IGNORED
Mapping: ff00.fd73 ---> IGNORED
Mapping: ff00.fd74 ---> IGNORED
Mapping: ff00.fd75 ---> IGNORED
Mapping: ff00.fd76 ---> IGNORED
Mapping: ff00.fd77 ---> IGNORED
Mapping: ff00.fd78 ---> IGNORED
Mapping: ff00.fd79 ---> IGNORED
Mapping: ff00.fd7a ---> IGNORED
Mapping: ff00.fd7b ---> IGNORED
Mapping: ff00.fd7c ---> IGNORED
Mapping: ff00.fd7d ---> IGNORED
Mapping: ff00.fd7e ---> IGNORED
Mapping: ff00.fd7f ---> IGNORED
Mapping: ff00.fd80 ---> IGNORED
Mapping: ff00.fd81 ---> IGNORED
Mapping: ff00.fd82 ---> IGNORED
Mapping: ff00.fd83 ---> IGNORED
Mapping: ff00.fd84 ---> IGNORED
Mapping: ff00.fd85 ---> IGNORED
Mapping: ff00.fd86 ---> IGNORED
Mapping: ff00.fd87 ---> IGNORED
Mapping: ff00.fd88 ---> IGNORED
Mapping: ff00.fd89 ---> IGNORED
Mapping: ff00.fd8a ---> IGNORED
Mapping: ff00.fd8b ---> IGNORED
Mapping: ff00.fd8c ---> IGNORED
Mapping: ff00.fd8d ---> IGNORED
Mapping: ff00.fd8e ---> IGNORED
Mapping: ff00.fd8f ---> IGNORED
Mapping: ff00.fd90 ---> IGNORED
Mapping: ff00.fd91 ---> IGNORED
Mapping: ff00.fd92 ---> IGNORED
Mapping: ff00.fd93 ---> IGNORED
Mapping: ff00.fd94 ---> IGNORED
Mapping: ff00.fd95 ---> IGNORED
Mapping: ff00.fd96 ---> IGNORED
Mapping: ff00.fd97 ---> IGNORED
Mapping: ff00.fd98 ---> IGNORED
Mapping: ff00.fd99 ---> IGNORED
Mapping: ff00.fd9a ---> IGNORED
Mapping: ff00.fd9b ---> IGNORED
Mapping: ff00.fd9c ---> IGNORED
Mapping: ff00.fd9d ---> IGNORED
Mapping: ff00.fd9e ---> IGNORED
Mapping: ff00.fd9f ---> IGNORED
Mapping: ff00.fda0 ---> IGNORED
Mapping: ff00.fda1 ---> IGNORED
Mapping: ff00.fda2 ---> IGNORED
Mapping: ff00.fda3 ---> IGNORED
Mapping: ff00.fda4 ---> IGNORED
Mapping: ff00.fda5 ---> IGNORED
Mapping: ff00.fda6 ---> IGNORED
Mapping: ff00.fda7 ---> IGNORED
Mapping: ff00.fda8 ---> IGNORED
Mapping: ff00.fda9 ---> IGNORED
Mapping: ff00.fdaa ---> IGNORED
Mapping: ff00.fdab ---> IGNORED
Mapping: ff00.fdac ---> IGNORED
Mapping: ff00.fdad ---> IGNORED
Mapping: ff00.fdae ---> IGNORED
Mapping: ff00.fdaf ---> IGNORED
Mapping: ff00.fdb0 ---> IGNORED
Mapping: ff00.fdb1 ---> IGNORED
Mapping: ff00.fdb2 ---> IGNORED
Mapping: ff00.fdb3 ---> IGNORED
Mapping: ff00.fdb4 ---> IGNORED
Mapping: ff00.fdb5 ---> IGNORED
Mapping: ff00.fdb6 ---> IGNORED
Mapping: ff00.fdb7 ---> IGNORED
Mapping: ff00.fdb8 ---> IGNORED
Mapping: ff00.fdb9 ---> IGNORED
Mapping: ff00.fdba ---> IGNORED
Mapping: ff00.fdbb ---> IGNORED
Mapping: ff00.fdbc ---> IGNORED
Mapping: ff00.fdbd ---> IGNORED
Mapping: ff00.fdbe ---> IGNORED
Mapping: ff00.fdbf ---> IGNORED
Mapping: ff00.fdc0 ---> IGNORED
Mapping: ff00.fdc1 ---> IGNORED
Mapping: ff00.fdc2 ---> IGNORED
Mapping: ff00.fdc3 ---> IGNORED
Mapping: ff00.fdc4 ---> IGNORED
Mapping: ff00.fdc5 ---> IGNORED
Mapping: ff00.fdc6 ---> IGNORED
Mapping: ff00.fdc7 ---> IGNORED
Mapping: ff00.fdc8 ---> IGNORED
Mapping: ff00.fdc9 ---> IGNORED
Mapping: ff00.fdca ---> IGNORED
Mapping: ff00.fdcb ---> IGNORED
Mapping: ff00.fdcc ---> IGNORED
Mapping: ff00.fdcd ---> IGNORED
Mapping: ff00.fdce ---> IGNORED
Mapping: ff00.fdcf ---> IGNORED
Mapping: ff00.fdd0 ---> IGNORED
Mapping: ff00.fdd1 ---> IGNORED
Mapping: ff00.fdd2 ---> IGNORED
Mapping: ff00.fdd3 ---> IGNORED
Mapping: ff00.fdd4 ---> IGNORED
Mapping: ff00.fdd5 ---> IGNORED
Mapping: ff00.fdd6 ---> IGNORED
Mapping: ff00.fdd7 ---> IGNORED
Mapping: ff00.fdd8 ---> IGNORED
Mapping: ff00.fdd9 ---> IGNORED
Mapping: ff00.fdda ---> IGNORED
Mapping: ff00.fddb ---> IGNORED
Mapping: ff00.fddc ---> IGNORED
Mapping: ff00.fddd ---> IGNORED
Mapping: ff00.fdde ---> IGNORED
Mapping: ff00.fddf ---> IGNORED
Mapping: ff00.fde0 ---> IGNORED
Mapping: ff00.fde1 ---> IGNORED
Mapping: ff00.fde2 ---> IGNORED
Mapping: ff00.fde3 ---> IGNORED
Mapping: ff00.fde4 ---> IGNORED
Mapping: ff00.fde5 ---> IGNORED
Mapping: ff00.fde6 ---> IGNORED
Mapping: ff00.fde7 ---> IGNORED
Mapping: ff00.fde8 ---> IGNORED
Mapping: ff00.fde9 ---> IGNORED
Mapping: ff00.fdea ---> IGNORED
Mapping: ff00.fdeb ---> IGNORED
Mapping: ff00.fdec ---> IGNORED
Mapping: ff00.fded ---> IGNORED
Mapping: ff00.fdee ---> IGNORED
Mapping: ff00.fdef ---> IGNORED
Mapping: ff00.fdf0 ---> IGNORED
Mapping: ff00.fdf1 ---> IGNORED
Mapping: ff00.fdf2 ---> IGNORED
Mapping: ff00.fdf3 ---> IGNORED
Mapping: ff00.fdf4 ---> IGNORED
Mapping: ff00.fdf5 ---> IGNORED
Mapping: ff00.fdf6 ---> IGNORED
Mapping: ff00.fdf7 ---> IGNORED
Mapping: ff00.fdf8 ---> IGNORED
Mapping: ff00.fdf9 ---> IGNORED
Mapping: ff00.fdfa ---> IGNORED
Mapping: ff00.fdfb ---> IGNORED
Mapping: ff00.fdfc ---> IGNORED
Mapping: ff00.fdfd ---> IGNORED
Mapping: ff00.fdfe ---> IGNORED
Mapping: ff00.fdff ---> IGNORED
Mapping: ff00.ff02 ---> IGNORED
Mapping: GenericDesktop.Wheel ---> Relative.?
Mapping: Consumer.HorizontalWheel ---> Relative.?
Mapping: ff00.ff02 ---> IGNORED
Mapping: ff00.fe01 ---> IGNORED
Mapping: ff00.fe02 ---> IGNORED
Mapping: ff00.fe00 ---> IGNORED
Mapping: ff00.ff03 ---> IGNORED
Mapping: ff00.ff0b ---> IGNORED
Mapping: ff00.ff0d ---> IGNORED
Mapping: GenericDesktop.0000 ---> Absolute.Misc
Mapping: GenericDesktop.Pointer ---> Absolute.?
Mapping: GenericDesktop.Mouse ---> Absolute.?
Mapping: GenericDesktop.0003 ---> Absolute.?
Mapping: GenericDesktop.Joystick ---> Absolute.?
Mapping: GenericDesktop.GamePad ---> Absolute.?
Mapping: GenericDesktop.Keyboard ---> Absolute.?
Mapping: GenericDesktop.Keypad ---> Absolute.?
Mapping: GenericDesktop.MultiAxis ---> Absolute.?
Mapping: GenericDesktop.0009 ---> Absolute.?
Mapping: GenericDesktop.000a ---> Absolute.?
Mapping: GenericDesktop.000b ---> Absolute.?
Mapping: GenericDesktop.000c ---> Absolute.?
Mapping: GenericDesktop.000d ---> Absolute.?
Mapping: GenericDesktop.000e ---> Absolute.?
Mapping: GenericDesktop.000f ---> Absolute.?
Mapping: GenericDesktop.0010 ---> Absolute.?
Mapping: GenericDesktop.0011 ---> Absolute.?
Mapping: GenericDesktop.0012 ---> Absolute.?
Mapping: GenericDesktop.0013 ---> Absolute.?
Mapping: GenericDesktop.0014 ---> Absolute.?
Mapping: GenericDesktop.0015 ---> Absolute.?
Mapping: GenericDesktop.0016 ---> Absolute.?
Mapping: GenericDesktop.0017 ---> Absolute.?
Mapping: GenericDesktop.0018 ---> IGNORED
Mapping: GenericDesktop.0019 ---> IGNORED
Mapping: GenericDesktop.001a ---> IGNORED
Mapping: GenericDesktop.001b ---> IGNORED
Mapping: GenericDesktop.001c ---> IGNORED
Mapping: GenericDesktop.001d ---> IGNORED
Mapping: GenericDesktop.001e ---> IGNORED
Mapping: GenericDesktop.001f ---> IGNORED
Mapping: GenericDesktop.0020 ---> IGNORED
Mapping: GenericDesktop.0021 ---> IGNORED
Mapping: GenericDesktop.0022 ---> IGNORED
Mapping: GenericDesktop.0023 ---> IGNORED
Mapping: GenericDesktop.0024 ---> IGNORED
Mapping: GenericDesktop.0025 ---> IGNORED
Mapping: GenericDesktop.0026 ---> IGNORED
Mapping: GenericDesktop.0027 ---> IGNORED
Mapping: GenericDesktop.0028 ---> IGNORED
Mapping: GenericDesktop.0029 ---> IGNORED
Mapping: GenericDesktop.002a ---> IGNORED
Mapping: GenericDesktop.002b ---> IGNORED
Mapping: GenericDesktop.002c ---> IGNORED
Mapping: GenericDesktop.002d ---> IGNORED
Mapping: GenericDesktop.002e ---> IGNORED
Mapping: GenericDesktop.002f ---> IGNORED
Mapping: GenericDesktop.X ---> Absolute.X
Mapping: GenericDesktop.Y ---> Absolute.Y
Mapping: GenericDesktop.Z ---> Absolute.Z
Mapping: GenericDesktop.Rx ---> Absolute.Rx
Mapping: GenericDesktop.Ry ---> Absolute.Ry
Mapping: GenericDesktop.Rz ---> Absolute.Rz
Mapping: GenericDesktop.Slider ---> Absolute.Throttle
Mapping: GenericDesktop.Dial ---> Absolute.Rudder
Mapping: GenericDesktop.Wheel ---> Absolute.Wheel
Mapping: GenericDesktop.HatSwitch ---> Absolute.Hat0X
Mapping: GenericDesktop.CountedBuffer ---> IGNORED
Mapping: GenericDesktop.ByteCount ---> IGNORED
Mapping: GenericDesktop.MotionWakeup ---> IGNORED
Mapping: GenericDesktop.Start ---> Key.BtnStart
Mapping: GenericDesktop.Select ---> Key.BtnSelect
Mapping: GenericDesktop.003f ---> IGNORED
Mapping: GenericDesktop.Vx ---> IGNORED
Mapping: GenericDesktop.Vy ---> IGNORED
Mapping: GenericDesktop.Vz ---> IGNORED
Mapping: GenericDesktop.Vbrx ---> IGNORED
Mapping: GenericDesktop.Vbry ---> IGNORED
Mapping: GenericDesktop.Vbrz ---> IGNORED
Mapping: GenericDesktop.Vno ---> IGNORED
Mapping: GenericDesktop.0047 ---> IGNORED
Mapping: GenericDesktop.0048 ---> IGNORED
Mapping: GenericDesktop.0049 ---> IGNORED
Mapping: GenericDesktop.004a ---> IGNORED
Mapping: GenericDesktop.004b ---> IGNORED
Mapping: GenericDesktop.004c ---> IGNORED
Mapping: GenericDesktop.004d ---> IGNORED
Mapping: GenericDesktop.004e ---> IGNORED
Mapping: GenericDesktop.004f ---> IGNORED
Mapping: GenericDesktop.0050 ---> IGNORED
Mapping: GenericDesktop.0051 ---> IGNORED
Mapping: GenericDesktop.0052 ---> IGNORED
Mapping: GenericDesktop.0053 ---> IGNORED
Mapping: GenericDesktop.0054 ---> IGNORED
Mapping: GenericDesktop.0055 ---> IGNORED
Mapping: GenericDesktop.0056 ---> IGNORED
Mapping: GenericDesktop.0057 ---> IGNORED
Mapping: GenericDesktop.0058 ---> IGNORED
Mapping: GenericDesktop.0059 ---> IGNORED
Mapping: GenericDesktop.005a ---> IGNORED
Mapping: GenericDesktop.005b ---> IGNORED
Mapping: GenericDesktop.005c ---> IGNORED
Mapping: GenericDesktop.005d ---> IGNORED
Mapping: GenericDesktop.005e ---> IGNORED
Mapping: GenericDesktop.005f ---> IGNORED
Mapping: GenericDesktop.0060 ---> IGNORED
Mapping: GenericDesktop.0061 ---> IGNORED
Mapping: GenericDesktop.0062 ---> IGNORED
Mapping: GenericDesktop.0063 ---> IGNORED
Mapping: GenericDesktop.0064 ---> IGNORED
Mapping: GenericDesktop.0065 ---> IGNORED
Mapping: GenericDesktop.0066 ---> IGNORED
Mapping: GenericDesktop.0067 ---> IGNORED
Mapping: GenericDesktop.0068 ---> IGNORED
Mapping: GenericDesktop.0069 ---> IGNORED
Mapping: GenericDesktop.006a ---> IGNORED
Mapping: GenericDesktop.006b ---> IGNORED
Mapping: GenericDesktop.006c ---> IGNORED
Mapping: GenericDesktop.006d ---> IGNORED
Mapping: GenericDesktop.006e ---> IGNORED
Mapping: GenericDesktop.006f ---> IGNORED
Mapping: GenericDesktop.0070 ---> IGNORED
Mapping: GenericDesktop.0071 ---> IGNORED
Mapping: GenericDesktop.0072 ---> IGNORED
Mapping: GenericDesktop.0073 ---> IGNORED
Mapping: GenericDesktop.0074 ---> IGNORED
Mapping: GenericDesktop.0075 ---> IGNORED
Mapping: GenericDesktop.0076 ---> IGNORED
Mapping: GenericDesktop.0077 ---> IGNORED
Mapping: GenericDesktop.0078 ---> IGNORED
Mapping: GenericDesktop.0079 ---> IGNORED
Mapping: GenericDesktop.007a ---> IGNORED
Mapping: GenericDesktop.007b ---> IGNORED
Mapping: GenericDesktop.007c ---> IGNORED
Mapping: GenericDesktop.007d ---> IGNORED
Mapping: GenericDesktop.007e ---> IGNORED
Mapping: GenericDesktop.007f ---> IGNORED
Mapping: GenericDesktop.SystemControl ---> IGNORED
Mapping: GenericDesktop.SystemPowerDown ---> Key.Power
Mapping: GenericDesktop.SystemSleep ---> Key.Sleep
Mapping: GenericDesktop.SystemWakeUp ---> Key.WakeUp
Mapping: GenericDesktop.SystemContextMenu ---> IGNORED
Mapping: GenericDesktop.SystemMainMenu ---> IGNORED
Mapping: GenericDesktop.SystemAppMenu ---> IGNORED
Mapping: GenericDesktop.SystemMenuHelp ---> IGNORED
Mapping: GenericDesktop.SystemMenuExit ---> IGNORED
Mapping: GenericDesktop.SystemMenuSelect ---> IGNORED
Mapping: GenericDesktop.SystemMenuRight ---> IGNORED
Mapping: GenericDesktop.SystemMenuLeft ---> IGNORED
Mapping: GenericDesktop.SystemMenuUp ---> IGNORED
Mapping: GenericDesktop.SystemMenuDown ---> IGNORED
Mapping: GenericDesktop.008e ---> IGNORED
Mapping: GenericDesktop.008f ---> IGNORED
Mapping: GenericDesktop.D-PadUp ---> Absolute.Hat0Y
Mapping: GenericDesktop.D-PadDown ---> IGNORED
Mapping: GenericDesktop.D-PadRight ---> IGNORED
Mapping: GenericDesktop.D-PadLeft ---> IGNORED
Mapping: GenericDesktop.0094 ---> IGNORED
Mapping: GenericDesktop.0095 ---> IGNORED
Mapping: GenericDesktop.0096 ---> IGNORED
Mapping: GenericDesktop.0097 ---> IGNORED
Mapping: GenericDesktop.0098 ---> IGNORED
Mapping: GenericDesktop.0099 ---> IGNORED
Mapping: GenericDesktop.009a ---> IGNORED
Mapping: GenericDesktop.009b ---> IGNORED
Mapping: GenericDesktop.009c ---> IGNORED
Mapping: GenericDesktop.009d ---> IGNORED
Mapping: GenericDesktop.009e ---> IGNORED
Mapping: GenericDesktop.009f ---> IGNORED
Mapping: GenericDesktop.00a0 ---> IGNORED
Mapping: GenericDesktop.00a1 ---> IGNORED
Mapping: GenericDesktop.00a2 ---> IGNORED
Mapping: GenericDesktop.00a3 ---> IGNORED
Mapping: GenericDesktop.00a4 ---> IGNORED
Mapping: GenericDesktop.00a5 ---> IGNORED
Mapping: GenericDesktop.00a6 ---> IGNORED
Mapping: GenericDesktop.00a7 ---> IGNORED
Mapping: GenericDesktop.00a8 ---> IGNORED
Mapping: GenericDesktop.00a9 ---> IGNORED
Mapping: GenericDesktop.00aa ---> IGNORED
Mapping: GenericDesktop.00ab ---> IGNORED
Mapping: GenericDesktop.00ac ---> IGNORED
Mapping: GenericDesktop.00ad ---> IGNORED
Mapping: GenericDesktop.00ae ---> IGNORED
Mapping: GenericDesktop.00af ---> IGNORED
Mapping: GenericDesktop.00b0 ---> IGNORED
Mapping: GenericDesktop.00b1 ---> IGNORED
Mapping: GenericDesktop.00b2 ---> IGNORED
Mapping: GenericDesktop.00b3 ---> IGNORED
Mapping: GenericDesktop.00b4 ---> IGNORED
Mapping: GenericDesktop.00b5 ---> IGNORED
Mapping: GenericDesktop.00b6 ---> IGNORED
Mapping: GenericDesktop.00b7 ---> IGNORED
Mapping: GenericDesktop.00b8 ---> IGNORED
Mapping: GenericDesktop.00b9 ---> IGNORED
Mapping: GenericDesktop.00ba ---> IGNORED
Mapping: GenericDesktop.00bb ---> IGNORED
Mapping: GenericDesktop.00bc ---> IGNORED
Mapping: GenericDesktop.00bd ---> IGNORED
Mapping: GenericDesktop.00be ---> IGNORED
Mapping: GenericDesktop.00bf ---> IGNORED
Mapping: GenericDesktop.00c0 ---> IGNORED
Mapping: GenericDesktop.00c1 ---> IGNORED
Mapping: GenericDesktop.00c2 ---> IGNORED
Mapping: GenericDesktop.00c3 ---> IGNORED
Mapping: GenericDesktop.00c4 ---> IGNORED
Mapping: GenericDesktop.00c5 ---> IGNORED
Mapping: GenericDesktop.00c6 ---> IGNORED
Mapping: GenericDesktop.00c7 ---> IGNORED
Mapping: GenericDesktop.00c8 ---> IGNORED
Mapping: GenericDesktop.00c9 ---> IGNORED
Mapping: GenericDesktop.00ca ---> IGNORED
Mapping: GenericDesktop.00cb ---> IGNORED
Mapping: GenericDesktop.00cc ---> IGNORED
Mapping: GenericDesktop.00cd ---> IGNORED
Mapping: GenericDesktop.00ce ---> IGNORED
Mapping: GenericDesktop.00cf ---> IGNORED
Mapping: GenericDesktop.00d0 ---> IGNORED
Mapping: GenericDesktop.00d1 ---> IGNORED
Mapping: GenericDesktop.00d2 ---> IGNORED
Mapping: GenericDesktop.00d3 ---> IGNORED
Mapping: GenericDesktop.00d4 ---> IGNORED
Mapping: GenericDesktop.00d5 ---> IGNORED
Mapping: GenericDesktop.00d6 ---> IGNORED
Mapping: GenericDesktop.00d7 ---> IGNORED
Mapping: GenericDesktop.00d8 ---> IGNORED
Mapping: GenericDesktop.00d9 ---> IGNORED
Mapping: GenericDesktop.00da ---> IGNORED
Mapping: GenericDesktop.00db ---> IGNORED
Mapping: GenericDesktop.00dc ---> IGNORED
Mapping: GenericDesktop.00dd ---> IGNORED
Mapping: GenericDesktop.00de ---> IGNORED
Mapping: GenericDesktop.00df ---> IGNORED
Mapping: GenericDesktop.00e0 ---> IGNORED
Mapping: GenericDesktop.00e1 ---> IGNORED
Mapping: GenericDesktop.00e2 ---> IGNORED
Mapping: GenericDesktop.00e3 ---> IGNORED
Mapping: GenericDesktop.00e4 ---> IGNORED
Mapping: GenericDesktop.00e5 ---> IGNORED
Mapping: GenericDesktop.00e6 ---> IGNORED
Mapping: GenericDesktop.00e7 ---> IGNORED
Mapping: GenericDesktop.00e8 ---> IGNORED
Mapping: GenericDesktop.00e9 ---> IGNORED
Mapping: GenericDesktop.00ea ---> IGNORED
Mapping: GenericDesktop.00eb ---> IGNORED
Mapping: GenericDesktop.00ec ---> IGNORED
Mapping: GenericDesktop.00ed ---> IGNORED
Mapping: GenericDesktop.00ee ---> IGNORED
Mapping: GenericDesktop.00ef ---> IGNORED
Mapping: GenericDesktop.00f0 ---> IGNORED
Mapping: GenericDesktop.00f1 ---> IGNORED
Mapping: GenericDesktop.00f2 ---> IGNORED
Mapping: GenericDesktop.00f3 ---> IGNORED
Mapping: GenericDesktop.00f4 ---> IGNORED
Mapping: GenericDesktop.00f5 ---> IGNORED
Mapping: GenericDesktop.00f6 ---> IGNORED
Mapping: GenericDesktop.00f7 ---> IGNORED
Mapping: GenericDesktop.00f8 ---> IGNORED
Mapping: GenericDesktop.00f9 ---> IGNORED
Mapping: GenericDesktop.00fa ---> IGNORED
Mapping: GenericDesktop.00fb ---> IGNORED
Mapping: GenericDesktop.00fc ---> IGNORED
Mapping: GenericDesktop.00fd ---> IGNORED
Mapping: GenericDesktop.00fe ---> IGNORED
Mapping: GenericDesktop.00ff ---> IGNORED

There were so many messages that some of them were discarded in the
begining, hope they arent interesting to you.

This is the lsusb -v for that device:

Bus 003 Device 002: ID 045e:00e3 Microsoft Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x00e3
  bcdDevice            0.53
  iManufacturer           1 Microsft
  iProduct                2 Microsoft Wireless Optical Desktop(r) 2.20
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      63
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     571
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10

This name microsoft wireless optical desktop is the same name that is
written under the receiver, except that the version mentioned is 3.0A,
not 2.20

Hope im not putting too much information in just one email, but there
is a weird issue with t he mouse. It registers a joystick interface as
well, that has so many buttons and axes that it segfaults all the
programs i know that report joystick events:

~ $ jstest /dev/input/js0
Driver version is 2.1.0.
Joystick (Microsft Microsoft Wireless Optical Desktop 2.20) has 37
axes (X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,
X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X)
Segmentation fault

The only program i can use to watch the events is mplayer. There i can
see for example that pressing the left right and middle mouse buttons
also generates some joystick events, button presses to be more exact.
This mouse also has side scrolls, which doesnt generate any events.

This joystick interface behaves so badly and seems useless, it only
causes problems at the moment, so i would rather have it blacklisted.

Hope i didnt miss any information.
