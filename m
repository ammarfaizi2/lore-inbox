Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271676AbRIGK35>; Fri, 7 Sep 2001 06:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRIGK3r>; Fri, 7 Sep 2001 06:29:47 -0400
Received: from b73254.upc-b.chello.nl ([212.83.73.254]:60420 "EHLO
	kleintje.nozone.nl") by vger.kernel.org with ESMTP
	id <S271676AbRIGK33>; Fri, 7 Sep 2001 06:29:29 -0400
Date: Fri, 7 Sep 2001 12:29:49 +0200 (CEST)
From: Tony den Haan <tony@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: RE: 2.4.8/9 panic on serial with MSI-694D MB
In-Reply-To: <000001c12f19$94010ff0$f5237ad5@hayholt>
Message-ID: <Pine.LNX.4.21.0109071226390.2078-100000@kleintje.nozone.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Laramie Leavitt wrote:

> This appears to be the same crash that I have reported 3 times 
> over the last few weeks.  I have not heard anything, but I suspected
> that it was a console bug because I have 2 video cards and
> the <c0105262> addresses are in vgacon...  I didn't think that
> it might be the serial port.
> 
> Thanks for the pointer.  2.4.9 SMP now boots, and everything
> Seems to work alright.  My new config does not use serial or
> any power management.
> 
> It only appears in SMP mode (I can boot any kernel with maxcpus=1)
> so it is probably a locking problem.  I did notice that mine stopped
> right after printing a notice about ttyS0, but the oops pushed that 
> Off the screen.

if did more checking, problem started with 2.4.7
serial.c did show up in patch-2.4.7 :-)

tony

