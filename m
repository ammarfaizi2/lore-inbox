Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSB0ACv>; Tue, 26 Feb 2002 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289901AbSB0ACp>; Tue, 26 Feb 2002 19:02:45 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:62730 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S289813AbSB0ACF>;
	Tue, 26 Feb 2002 19:02:05 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Denis Zaitsev <zzz@cd-club.ru>
Date: Wed, 27 Feb 2002 01:01:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] matroxfb_base.c - a little fix
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <12F2A62A4FF4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 02 at 3:36, Denis Zaitsev wrote:
> BTW, a little question: you use the (green.length == 5) test to
> distinct bpp15 from bpp16 (matroxfb_base.c:509).  Why?  Is the "real"
> 15 not used as the bits_per_pixel's value?  Thanks in advance.

Yes, it is per spec. bits_per_pixel is bits per pixel, and for both
1:5:5:5 and 5:6:5 this is 16. Matrox hardware does not support 15bpp
pixels (16 pixels in 15 bytes)...
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
