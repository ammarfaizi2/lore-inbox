Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTA1Pvb>; Tue, 28 Jan 2003 10:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTA1Pva>; Tue, 28 Jan 2003 10:51:30 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:36065 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S267346AbTA1Pv2>;
	Tue, 28 Jan 2003 10:51:28 -0500
Message-ID: <3E36A91F.8F1168DB@cicese.mx>
Date: Tue, 28 Jan 2003 08:00:31 -0800
From: Serguei Miridonov <mirsev@cicese.mx>
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: any brand recomendation for a linux laptop ?
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr> <20030116113825.GB21239@codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing this in Compaq Presario 900Z which seems to be similar to your Evo
1015v. After installing RedHat 7.3 with nomce, nopci, etc. I've disabled kudzu and
then compiled 2.4.20+ac2+acpi-20021212-2.4.20 with sound and IDE fixes. Now I have
UDMA IDE, sound, and 802.11b with prism card (actually I'm writing this at home on
remotely running Netscape in my office over X11/ssh/ADSL/wireless home FW8-604
router;). The only option left for kernel is ide-scsi, the rest is done by the
kernel automatically.

ACPI patch with acpid and aKpi provide correct information about battery status.
Did not try any goodies like suspend and hibernate yet.

The only problem is ATI IGP320M graphics. I can use only VESA X driver but it works
fast enough even in 32bpp with 1400x1050 resolution.

In conclusion, I'm quite happy with this notebook: some trouble with installation
but overall impression is very good.

Dave Jones wrote:

> On Thu, Jan 16, 2003 at 11:00:45AM +0100, Nicolas Turro wrote:
>  >
>  > Hi,
>  > I am software engineer at a french research institute, in charge of the linux
>  > support on about 600 computers. I am looking for laptops whith linux
>  > support/certification. I couln't find any recent laptop model on your
>  > certification page. Would you recomend me any brand of computer ?
>  > We curently buy Compaq Evos laptops, but enabling linux on those laptops
>  > is terrible :
>  > - power management seems to be ACPI only (which linux barely supports)
>  > - sound is hard or impossible to setup correctly.
>
> I have an Evo 1015v, which is a bit of a pain to get working.
> You need a very recent kernel just to be able to boot the thing, or
> it'll lock up during hardware detection. Installer kernels typically
> need to be booted with 'nomce', or probing causes a machine check.
> The ATi Xserver locks up with a pretty display of garbage, (use
> the vesa driver). Sound is currently not working afaik.
> Power management: ACPI worked on it. Up until recently. Latest
> 2.5 seems to lock up very early in the boot.
> Native Athlon Powernow support for cpufreq I'm working on, and am
> making progress. IDE is a bit hit and miss. It works, but it's
> no screamer in the performance dept. (Likely because no-one has
> the relevant info from ATi on their south bridge).
> AGP support is also lacking due to missing docs. DRI support
> for that onboard Radeon mobility is afaik also missing.
> Vesafb works.
>
> So.. it's not that bad when you know the pitfalls, and it gets a good
> 3hrs or so on battery. (Which is pretty good for a 1300MHz CPU & large
> display).
>
> The key to why this one was such a pain was very likely the
> "Designed for Windows XP" logo stuck to it.
>
>                 Dave
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Serguei Miridonov                CICESE, Research Center,
CICESE, Optics Dept.             Ensenada B.C., Mexico
PO Box 434944                    E-mail: mirsev@cicese.mx
San Diego, CA 92143-4944         FAX: +52 (646) 1750553
U.S.A.



