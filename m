Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289708AbSA2PXF>; Tue, 29 Jan 2002 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289699AbSA2PWq>; Tue, 29 Jan 2002 10:22:46 -0500
Received: from [213.171.51.190] ([213.171.51.190]:51626 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S289698AbSA2PWm>;
	Tue, 29 Jan 2002 10:22:42 -0500
Date: Tue, 29 Jan 2002 18:22:31 +0300
From: Nikita Gergel <fc@yauza.ru>
To: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.3-pre5] BUG on boot
Message-Id: <20020129182231.615270dd.fc@yauza.ru>
In-Reply-To: <7624197.q1iQU4070A@newssend.sf-tec.de>
In-Reply-To: <7624197.q1iQU4070A@newssend.sf-tec.de>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002 14:14:19 +0100
Rolf Eike Beer <eike@euklid.math.uni-mannheim.de> wrote:

> Yesterday I tried to boot 2.5.3-pre5 on my Compaq ProSignia 
> (486DX2-66,36MB RAM, SCSI-only).
> 
> Output written down from screen, so maybe threre is a typo. If someone 
> needs .config or something more just ask.
> 
> devfs: V1.10 ( 20020120) ...
> devfs: boot_options: 0x1
> Kernel BUG ar slab.c: 641
> invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c0125398>] Not tainted
> EFLAGS: 00010286
> eax: 0000001a ebx: c023d030 ecx: c0221280 edx: 00000866
> esi: 00000184 edi: c01fea28 ebp: 00000000 esp: c10a5f84
> ds: 0018 es: 0018 ss: 0018
> Process swapper (pid 1: stackpage= c10a5000)
> stack: c01ef750 00000281 c023d030 c0231fd4 00000000 0008e000
>        c0224aa0 00000000 c0132338 c0224aa0 c023d02c c0231fd4
>        c017133d c01fea13 00000184 00000000 00002000 c01712f0
>        00000000 c0239326 c023d030 c02326ba 00010f00 c02326f5
> Call trace c0132338 c017133d c01712f0 c0105027 c0107078
> Code 0f 0b 83 c4 08 8d 76 00 f7 44 24 38 ff 0f ff ff 74 16 68 a0
> <0>Kernel panic: attempt to kill init!
> 
> Eike
> -- 
> Es wäre schon wünschenswert, wenn die DAUs das Stück toten Baum, was
> mit der Suse mitkommt, nutzen würden. Entweder zum Lesen, oder um sich
> damit so lange auf den Schädel zu hauen, bis die Kollegen vom RD
> anrücken müssen.        Hauke Heidtmann in feuerwehrmann.talk

I've this BUG(), too. 2.5.2-pre10 works well on my machine.

PIII-100Mhz
RAM - 256M

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom
