Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSHVUxT>; Thu, 22 Aug 2002 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHVUxT>; Thu, 22 Aug 2002 16:53:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:50180 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id <S317264AbSHVUxS>;
	Thu, 22 Aug 2002 16:53:18 -0400
Date: Thu, 22 Aug 2002 16:57:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: <stern@ida.rowland.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andries Brouwer <aebr@win.tue.nl>, Dave Jones <davej@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Patch for PC keyboard driver's autorepeat-rate handling
In-Reply-To: <20020822193743.GA5448@win.tue.nl>
Message-ID: <Pine.LNX.4.33L2.0208221651370.1306-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked the source tree for the stock m68k port.  The only systems that
implement the KDKBDRATE ioctl are the amiga and atari ports, and they both
do it in accordance with the documentation and the kbdrate program (and
the patch I submitted earlier).

The relevant routines are drivers/char/amikeyb.c:amiga_kbdrate() and
arch/m68k/atari/atakeyb.c:atari_kbdrate().

Alan Stern

