Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRAAXRa>; Mon, 1 Jan 2001 18:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131433AbRAAXRV>; Mon, 1 Jan 2001 18:17:21 -0500
Received: from [199.239.160.155] ([199.239.160.155]:17288 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S131246AbRAAXRM>; Mon, 1 Jan 2001 18:17:12 -0500
Date: Mon, 1 Jan 2001 23:05:53 +0000
From: Robert Read <rread@datarithm.net>
To: Rafael Diniz <rafael2k@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PC-speaker control
Message-ID: <20010101230553.B8481@tenchi.datarithm.net>
Mail-Followup-To: Rafael Diniz <rafael2k@terra.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01010118360105.00896@rafael>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01010118360105.00896@rafael>; from rafael2k@terra.com.br on Mon, Jan 01, 2001 at 06:30:37PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this on the console:

setterm -blength 0

no assembly required. :)

robert


On Mon, Jan 01, 2001 at 06:30:37PM -0200, Rafael Diniz wrote:
> Hey, Is there a way to control the PC-speaker with the Linux kernel 2.2?
> I want to disable it.
> I guy told me that with this assembly code I can disable it:
> 	in al , 97
> 	and al,253
> 	out 97,al
> Linux 2.4 will have any syscall to do this?
> 
> Thanks
> Rafael Diniz
> Brazil
> =================================================
> Conectiva Linux 6.0 (2.2.17)  XFree86-4.0.1
> PII 233mhz 96Mb ram
> SB16, USR56k, S3 VirgeDX/GX 4Mb, CD creative48X 
> HDa 10Gb Quantum  HDb 4.1Gb Fugitsu
> MSX2.0 256k MegaRam 256k Mapper 128k Vram
> MSX is the future
> =================================================
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
