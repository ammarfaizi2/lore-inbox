Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130821AbRBPTM2>; Fri, 16 Feb 2001 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130949AbRBPTMI>; Fri, 16 Feb 2001 14:12:08 -0500
Received: from uhura.concentric.net ([206.173.118.93]:48322 "EHLO
	uhura.concentric.net") by vger.kernel.org with ESMTP
	id <S130821AbRBPTLt>; Fri, 16 Feb 2001 14:11:49 -0500
Date: Fri, 16 Feb 2001 11:11:31 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@zeus.concentric.net>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Xpert]Video drivers and the kernel
Message-ID: <Pine.LNX.4.31.0102161030100.26865-100000@zeus.concentric.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>(Aside, is this because X uses keyboard in raw mode?  would be nice to
>still be able to ctrl-alt-del to rebood from console)  Anyone know about
>using alt-sysrq to restore console?
>
>So, if the kernel had a card specific module that just knew enough
>to put the card back into text mode, or if it used the card's bios
>to do it like the int10.a module in XFree 4.0, we would lack for nothing.
>(hmm vesafb could be extended?)

Working on it. I already have it so you can go from vgacon to /dev/fb and
back to vgacon. It is in the works to have vgacon restore the text mode,
palette and fonts when switching away from the X server. One of the
problems I have seen is under heavy load switching away from X often
doesn't restore the text console properly. Vgacon could. This is also
handy when the X server dies :-) As for using the card's BIOS. Yuck yuck!!
We have other platforms to consider like PPC. PPC is a pretty popular platform.

