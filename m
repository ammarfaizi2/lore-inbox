Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUACKKj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 05:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUACKKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 05:10:39 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:50304 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265960AbUACKKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 05:10:37 -0500
Date: Sat, 3 Jan 2004 11:10:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: New set of input patches
Message-ID: <20040103101040.GC499@ucw.cz>
References: <200401030350.43437.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401030350.43437.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 03:50:43AM -0500, Dmitry Torokhov wrote:

> Hi Vojtech,
> 
> I have a new set of input patches, could you take look at them?
> 
> 1. i8042-suspend.patch
>    Add suspend methods to i8042 to restore BIOS settings on suspend and
>    kill polling timer which sometimes prevents APM suspend
> 

See comments.

> 2. i8042-options-parsing.patch
>    psmouse-options-parsing.patch

See comments.

>    atkbd-options.parsing
>    Complete conversion to the new way of parsing parameters. Drop "i8042_",
>    "psmouse_" and "atkbd_" prefixes from option names when compiled as a
>    module and require "i8042.", "psmouse." and "atkbd." prefixes if built
>    into the kernel.
> 
> 3. missing-module-license.patch
>    Maple and newton keyboard drivers were missing MODULE_LICENSE("GPL")
> 
> 4. kconfig-synaptics-help.patch
>    Suggest psmouse.proto=imps to Synaptics users who do not want install
>    native XFree Synaptics driver so taps would still work
> 
> 5. sis-aux-port.patch
>    Do not ignore AUX port if chipset fails to disable it when we do probes
>    as SiS is having trouble disabling but otherwise mouse works fine.

All patches except the first one are OK, in psmouse-options, there is a
little typo.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
