Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132155AbRCVTVr>; Thu, 22 Mar 2001 14:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132163AbRCVTVh>; Thu, 22 Mar 2001 14:21:37 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:48647 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132162AbRCVTVZ>; Thu, 22 Mar 2001 14:21:25 -0500
Message-ID: <3ABA5089.9DE6E8B7@Hell.WH8.TU-Dresden.De>
Date: Thu, 22 Mar 2001 20:20:41 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac21 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: kraxel@strusel007.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Weird bttv errors and video hangs with 2.4.2-ac21
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

With -ac21 I'm getting occasional long delays in video output with xawtv
or the picture totally freezes until I click with the mouse in the xawtv
window. dmesg shows:

bttv0: PLL: 28636363 => 35468950 ... ok
bttv0: irq: OCERR risc_count=0fb54810
bttv0: irq: OCERR risc_count=0fb54810
bttv0: irq: OCERR risc_count=0fb54810
bttv0: irq: SCERR risc_count=0fb54810
bttv0: irq: SCERR risc_count=0fb54810
bttv0: aiee: error loops
bttv0: resetting chip
bttv0: PLL: 28636363 => 35468950 ... ok
bttv0: irq: OCERR risc_count=0fb54810
bttv0: irq: OCERR risc_count=0fb54820
bttv0: irq: OCERR risc_count=0fb54810
bttv0: irq: OCERR risc_count=0fb54810
bttv0: irq: SCERR risc_count=0fb54810
bttv0: aiee: error loops
bttv0: irq: SCERR risc_count=0c898014
bttv0: aiee: error loops
bttv0: resetting chip
bttv0: PLL: 28636363 => 35468950 ... ok
bttv0: irq: OCERR risc_count=0fb54810

All of this did not happen with -ac20 under the exact same circumstances,
so -ac21 does something which the bttv driver (0.7.57) doesn't quite like.

Regards,
Udo.
