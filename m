Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSLNXGw>; Sat, 14 Dec 2002 18:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266053AbSLNXGw>; Sat, 14 Dec 2002 18:06:52 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:18565 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266043AbSLNXGv>; Sat, 14 Dec 2002 18:06:51 -0500
Date: Sat, 14 Dec 2002 17:14:43 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: i4l dtmf errors
In-Reply-To: <atg5jv$d73$1@fritz38552.news.dfncis.de>
Message-ID: <Pine.LNX.4.44.0212141712410.7099-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Wolfgang Fritz wrote:

> > it seems isdn4linux detects DTMF tones from normal speach. This is
> > rather annoying when using i4l for voice with Asterisk.org. This is
> > tested on all recent kernels
> 
> The DTMF detection is broken since kernel 2.0.x. I have a patch for a 
> 2.2 kernel which may manually be applied 2.4 kernels with some manual 
> work. It fixes an overflow problem in the goertzel algorithm (which 
> does the basic tone detection) and changes the algorithm to detect the 
> DTMF pairs. If interested, I can try to recover that patch.

If you dig out that patch and submit it (to me), I'm pretty sure there's 
a good chance of it going into the official kernel. ISTR there was talk 
about that earlier, but nothing ever happened.

--Kai


