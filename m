Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRCaHMf>; Sat, 31 Mar 2001 02:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRCaHM0>; Sat, 31 Mar 2001 02:12:26 -0500
Received: from [206.46.170.141] ([206.46.170.141]:39598 "EHLO smtp9ve.gte.net")
	by vger.kernel.org with ESMTP id <S132326AbRCaHMW>;
	Sat, 31 Mar 2001 02:12:22 -0500
Message-ID: <3AC58290.3E8E76C8@neuronet.pitt.edu>
Date: Sat, 31 Mar 2001 02:09:04 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Brook <jbk@postmark.net>
CC: mythos <papadako@csd.uoc.gr>, Alan Olsen <alan@clueserver.org>,
   Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
In-Reply-To: <20010331001238.10669.qmail@venus.postmark.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Brook wrote:
> 
> >With 2.4.2 it was working just fine.
> 
> I have also noticed problems with the 2.4.3 release. I have a G450
> 32Mb, that I use in single-head mode. The console framebuffer runs
> fine at boot time, but when I load X (4.0.3 compiled with Matrox HAL
> library) and then return to the console, I get a blank screen (signal
> lost).

In my case, when lilo boots my G450 on any video mode other than
'normal', going into X and then back into console, leads to a blank
screen. I've observed this behavior in 2.2 and 2.4. Otherwise, I've no
problem using the card in single or dual head.

Since the HAL lib is a binary, we might have to wait for Matrox to fix
this problem.

-- 
     Rafael
