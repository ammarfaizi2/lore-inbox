Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTAAPvj>; Wed, 1 Jan 2003 10:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTAAPvj>; Wed, 1 Jan 2003 10:51:39 -0500
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:38674
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id <S267273AbTAAPvg>; Wed, 1 Jan 2003 10:51:36 -0500
Message-ID: <3E13107E.3D579F3@justirc.net>
Date: Wed, 01 Jan 2003 10:59:58 -0500
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ide harddisk freeze WDC WD1800JB vs VIA VT8235
References: <1041435181.983.76.camel@sun>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q: are you using cables with a slave connector, but its not in use?
I had this problem, with this chipset and it turned out that it didnt like
having
a long 80 wire cable with a loose connector
I got a round cable with just 2 connectors, 1 for the board and 1 for the
drive....
never locked again.
I thought it to be strange as well.
but with my setup it happened more frequently, say once every 2-3 hours.
hope this is of any help.


Soeren Sonnenburg wrote:

> Hi.
>
> I still get harddisk freezes on 2 WD1800JB drives (asus A7V8X mobo),
> i.e., I have to powercycle the system to get the harddisk back working.
> A cold reset is not enough.
>
> The harddisks are connected to the primary and secondary via vt8235
> controller (both disks are master).
>
> When a harddisk 'freezes' the ide-light is continuosly on. When that
> happens the machine is still ping-able but since these two disk form a
> software raid0 the machine hangs on disk access.
>
> This problem happens like once in a week....and very seldom within 3
> days.
>
> The system is athlon xp 2.4G+ a7v8x mainboard 1.5g ddr333 memory kernel
> 2.4.21-pre2 (did not work with 2.4.20 that is why I went to the pre
> version)
>
> So far I have ruled out the following:
> - it is not a cable problem (tested several cables)
> - the memory of the machine seems to be ok (memtest ran for 2 days
> without reporting an error)
> - it is not a problem of the power supply (tested another powersupply)
> - the harddisk are ok ( I ran the vendors check program )
>
> Now it could be that the via vt8235 chipset has a bug, the linux ide
> handling code is buggy or the firmware of the drive is not ok.
>
> It is probably a vt8235 problem or linux driver problem since a I know
> of 8 wdc1800jb disks with that firmware version running since >1month in
> a hardware raid setup without problems.
>
> I attached the kernel config, dmesg, and hdparm -I of one of the drives.
>
> If you have any ideas/ need further infos don't hesitate to contact me.
>
> Thanks in advance,
> Soeren.
>
>   ------------------------------------------------------------------------
>              Name: config
>    config    Type: Plain Text (text/plain)
>          Encoding: 7bit
>
>             Name: dmesg
>    dmesg    Type: Plain Text (text/plain)
>         Encoding: 7bit
>
>              Name: hdparm
>    hdparm    Type: unspecified type (application/octet-stream)
>          Encoding: quoted-printable

--
Regards,
Mark Rutherford
mark@justirc.net




