Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSLLMJp>; Thu, 12 Dec 2002 07:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbSLLMJo>; Thu, 12 Dec 2002 07:09:44 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:6148 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S263279AbSLLMJo>;
	Thu, 12 Dec 2002 07:09:44 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de>
	<at2r5v$fib$1@cesium.transmeta.com> <20021210213444.GA451@elf.ucw.cz>
	<20021212094334.A1403@ucw.cz> <m3fzt35uh7.fsf@lugabout.jhcloos.org>
	<20021212125114.A10134@ucw.cz>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20021212125114.A10134@ucw.cz>
Date: 12 Dec 2002 07:17:22 -0500
Message-ID: <m3znrb4ejx.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

Vojtech> Do they by any chance produce a kernel warning when pressed?

Yes, the two keys that do not generate an event in X syslog these errors:

atkbd.c: Unknown key (set 2, scancode 0x176, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x176, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x11e, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x11e, on isa0060/serio0) released.

where 0x176 is the PLAY key and 0x11e is the PREV key.

Incidently, the FORWARD key is giving the same keycode as the main
kb's Pause key.

-JimC

