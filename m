Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbTCIMS5>; Sun, 9 Mar 2003 07:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262503AbTCIMS5>; Sun, 9 Mar 2003 07:18:57 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:37129 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262502AbTCIMS4>; Sun, 9 Mar 2003 07:18:56 -0500
Date: Sun, 9 Mar 2003 13:29:26 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds6.pg.gda.pl>
X-X-Sender: blues@piorun.ds.pg.gda.pl
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: Console weirdness
In-Reply-To: <Pine.SOL.4.31.0303091125560.28624-100000@pitsa.pld.ttu.ee>
Message-ID: <Pine.LNX.4.51L.0303091327460.6084@piorun.ds.pg.gda.pl>
References: <Pine.SOL.4.31.0303091125560.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Siim Vahtre wrote:
> > But still, switching back from X to console corrupts the display.
> > Switching back is fine though using the fbdev.diff patch. Without
> > switching back and force works fine, except that the last line isn't
> > properly redrawn (rivafb).
> I am using rivafb with 2.5.64-bk2 kernel and with latest fbdev patches
> and have following (minor) problems:

2.5.64 with latest fbdev patches.

> * switching to X and back ruins the colours totally. Soulution is to
> fbset back to default mode. (I've even made hotkey for that ;-) )
> 
> * changing modes(to other than 640x480) will change the resolution but
> not the 'console window' itself. That is - I have 640x480 window on the
> corner for text console but actually 800x600 resolution. (Maybe it is a
> feature? How to get it full-screened, anyway?)
> 
> * changing modes on one tty (even though -a was specified with fbset)
> will not change modes on other ttys. When switching ttys with different
> resolution, the screen blanks and I again have to use my hotkey to fbset
> back to default resolution.

I have the same problems on my tdfx (Voodoo3).

-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
