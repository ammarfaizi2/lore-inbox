Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283545AbRK3Hpn>; Fri, 30 Nov 2001 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283544AbRK3Hpe>; Fri, 30 Nov 2001 02:45:34 -0500
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:12942 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S283545AbRK3Hp2>; Fri, 30 Nov 2001 02:45:28 -0500
Message-ID: <3C07384C.6F9947D9@didntduck.org>
Date: Fri, 30 Nov 2001 02:42:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Walt Meservey <wmeservey@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Joysticks in 2.4 Kernel (SuSE 7.2 & 7.3)
In-Reply-To: <000001c1791b$c416f000$580e0b41@marin1.sfba.home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walt Meservey wrote:
> 
> Dear Mr. Pavlik,
> 
> I have SuSE 7.3 installed on my home PC, together with a SoundBlaster PCI
> 128 soundcard (es1370) and a joystick attached to the gameport.  The
> joystick is a Microsoft sidewinder, but I also have been equally
> unsuccessful with a generic analog joystick.  I noticed your message
> regarding the failure of the MODPROBE ns558 command.
> 
> I have two simple questions:
> 1. IS IT POSSIBLE TO GET A JOYSTICK WORKING with the 2.4 Kernel?
> 2. If it is possible to do it, could you provide instructions or point me to
> some sort of instruction/FAQ page?
> 
> Thanks!
> 
>                                                                                         Regards
> 
>                                                                                                 Walt Meservey
> 
> Better Living through Linux Gaming!

The es1370 sound driver handles the game port instead of ns558 for that
card.  The sound driver needs to set a control bit on the card to enable
the game port.

-- 

						Brian Gerst
