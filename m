Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBRSm5TGU8htQguxFh8lW4D55A==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 10:12:47 +0000
Message-ID: <00c301c415a4$14521500$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:53 +0100
X-Mailer: Microsoft CDO for Exchange 2000
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: <Administrator@osdl.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: New set of input patches
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
References: <200401030350.43437.dtor_core@ameritech.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200401030350.43437.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:53.0906 (UTC) FILETIME=[14AF2920:01C415A4]

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
