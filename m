Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSCTBuE>; Tue, 19 Mar 2002 20:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311199AbSCTBty>; Tue, 19 Mar 2002 20:49:54 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:53778 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S311180AbSCTBtm>; Tue, 19 Mar 2002 20:49:42 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A771C@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: FW: Intel PII machine hangs with MCE enabled in linux-2.4.19-pre3
Date: Tue, 19 Mar 2002 17:49:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 18, 2002 at 12:20 PM, Dual Mobius wrote:
> 
> Intel PII machine hangs with MCE enabled in
> linux-2.4.19-pre3
> 
> Under linux 2.4.19-pre3, my Intel Pentium II system
> hangs with the "machine check" turned on
> (CONFIG_X86_MCE=y).  The same machine booted correctly
> under 2.4.19-pre2 with MCE enabled.
> 
> I get the following output from the kernel when
> booting, and then it freezes:
> 
> [snip]
> 
> Intel machine check architecture supported.
>

Me too.

Pentium II mobile module in Motorola CPV5350, 2.4.19-pre3 kernel.
Hangs after boot message "Intel machine check architecture supported".
Turning off CONFIG-X86_MCE did not help in my case, but I didn't do a make
mrproper before recompiling the kernel ... so I suppose I don't really know
that for sure yet.

Best regards,

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

