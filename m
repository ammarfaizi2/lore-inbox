Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSAIOL2>; Wed, 9 Jan 2002 09:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAIOLS>; Wed, 9 Jan 2002 09:11:18 -0500
Received: from [212.50.10.141] ([212.50.10.141]:52187 "HELO ns.top.bg")
	by vger.kernel.org with SMTP id <S286895AbSAIOLG>;
	Wed, 9 Jan 2002 09:11:06 -0500
Message-ID: <3C3CDC2B.1B8B5C35@top.bg>
Date: Wed, 09 Jan 2002 16:11:23 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: uwe.teichmann@oracle.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q: I/O Problems with Linux 2.4.10 SMP on Tyan Tiger S2460 ?
In-Reply-To: <200201082058.g08Kw8l19074@rgmgw5.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found some similar broblems when upgrading from 440BX SMP board to Asus
CUVX-D (Via 694D) SMP Board
Try on Bios settings
Intel MultiProcessor Specification v1.4 -> change it to v1.1
If it doesn't work - try to recompile your kernel
It may be poor md (soft raid) performance under AMD processors

Uwe Teichmann wrote:

> Dear All,
>
> I'm running a Tyan Tiger S2460 with two Athlon MP 1700+, using SuSE 7.3
> 2.4.10 SMP Kernel. In addition i have 2 Adaptec 29160, each serving at the
> moment only one Seagate Cheetah disk. Creating with Oracle in parallel
> 4 datafiles each 1GB i come up with 34 MB/sec.
>
> On my previous Gigabyte i440 BX with SCSI U2W onboard using above Linux
> version and disk layout, i came up with 48 MB/sec.
>
> So, where is the problem ?
>
> Attached i have the dmesg command output. The only thing i can see is the
>
> CPU has inconsistent mtrr settings
>
> message. mtrr as a module is activated. Could this be the problem ? During
> the run of the above creation of the datafiles, i get the expression only
> cpu at a time works, but i do not know how to prove it.
>
> Thanks for any help.
>
> Ciao,
>
>   ------------------------------------------------------------------------
>                     Name: boot.messages
>    boot.messages    Type: Plain Text (text/plain)
>                 Encoding: 8bit

