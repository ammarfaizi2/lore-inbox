Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbRB0Lt3>; Tue, 27 Feb 2001 06:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRB0LtT>; Tue, 27 Feb 2001 06:49:19 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:12039 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129791AbRB0LtN>;
	Tue, 27 Feb 2001 06:49:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Dmitry B. Tsvetkov" <tdb@lou.cbr.ru>
Date: Tue, 27 Feb 2001 12:47:17 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PROBLEM: frame-buffer doesn't work on HP Vectra with Ma
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <9F36E64703@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 01 at 12:41, Dmitry B. Tsvetkov wrote:
> Description:   after  switching to VGA mode all messages appeared like
> dots  and  lines  over  HP  Bios  logo screen, only penguin logo looks
> normal  (on  previous 2.4.0 and 2.4.1 kernels it was shown using wrong
> colors or unvisible, but all fonts was shown normally).
> 
> Computers: HP Vectra VE6 series 8, Matrox G100
>            HP Vectra VLi 8, Matrox G200

Are you sure you did not enable vesafb + matroxfb or vga16fb + matroxfb
together? Boot Linux, and then post contents of /proc/fb to us.
If it contains anything else than '0 MATROX VGA', you misconfigured
your kernel.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
