Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbREQSd7>; Thu, 17 May 2001 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbREQSdt>; Thu, 17 May 2001 14:33:49 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:9481 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261476AbREQSdm>; Thu, 17 May 2001 14:33:42 -0400
Message-ID: <3B041980.BC22BA38@delusion.de>
Date: Thu, 17 May 2001 20:33:36 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Alan Cox wrote:
> 
> 2.4.4-ac10

With 2.4.4-ac10 and binutils 2.11 I get the following warnings:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o pci-pc.o pci-pc.c
pci-pc.c:964: warning: `pci_fixup_via691' defined but not used
pci-pc.c:977: warning: `pci_fixup_via691_2' defined but not used
{standard input}: Assembler messages:
{standard input}:747: Warning: indirect lcall without `*'
{standard input}:832: Warning: indirect lcall without `*'
{standard input}:919: Warning: indirect lcall without `*'
{standard input}:958: Warning: indirect lcall without `*'
{standard input}:990: Warning: indirect lcall without `*'
{standard input}:1022: Warning: indirect lcall without `*'
{standard input}:1053: Warning: indirect lcall without `*'
{standard input}:1082: Warning: indirect lcall without `*'
{standard input}:1111: Warning: indirect lcall without `*'
{standard input}:1392: Warning: indirect lcall without `*'
{standard input}:1497: Warning: indirect lcall without `*'

gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o apm.o apm.c
{standard input}: Assembler messages:
{standard input}:180: Warning: indirect lcall without `*'
{standard input}:274: Warning: indirect lcall without `*'


Does anyone know what's up with that? Kernel problem or binutils issue?

Regards,
Udo.
