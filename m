Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRKSIxs>; Mon, 19 Nov 2001 03:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRKSIxj>; Mon, 19 Nov 2001 03:53:39 -0500
Received: from [212.65.238.182] ([212.65.238.182]:25869 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S276094AbRKSIx2> convert rfc822-to-8bit; Mon, 19 Nov 2001 03:53:28 -0500
Message-ID: <35E64A70B5ACD511BCB0000000004CA1095C9A@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: MNL@MNL.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
Date: Mon, 19 Nov 2001 09:53:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please try to be more specific. Do you use VGA textmode console or NVidia
console framebuffer? I had also some freezes due to console framebuffer,
after returning closing X - the command line never appeared again. Try to
use only textmode console, NVidia framebuffer is currently in EXPERI-MENTAL
state :)

Regards,
Petr


> -----Pùvodní zpráva-----
> Od:	Michael N. Lipp [SMTP:MNL@MNL.de]
> Odesláno:	17. listopadu 2001 18:46
> Komu:	linux-kernel@vger.kernel.org
> Pøedmìt:	kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
> 
> Hello,
> 
> when I upgraded to 2.4.14, I found that console-switching doesn't work
> anymore with the latest NVIDIA driver installed. When I try to return
> to the console from X11 the system simply hangs (this includes
> shutdown, which makes it a real problem). Reverting to 2.4.13 fixed
> things. Sorry I can't report more hints.
> 
> Regards,
> 
>     Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
