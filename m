Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbSLDVoa>; Wed, 4 Dec 2002 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbSLDVoa>; Wed, 4 Dec 2002 16:44:30 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:22923
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S267103AbSLDVo3>; Wed, 4 Dec 2002 16:44:29 -0500
Date: Wed, 4 Dec 2002 16:50:50 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: "George G. Davis" <davis_g@attbi.com>, Jim Van Zandt <jrv@vanzandt.mv.com>,
       <device@lanana.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Why does the _DoubleTalk card_ not have a major assigned?
In-Reply-To: <20021204213325.GG2544@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0212041646190.775-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002, Adrian Bunk wrote:

> This is indeed true for the Comtrol Rocketport card but there's no
> major for the DoubleTalk card (and this is the card I wanted to write
> about).

Maybe because it doesn't need a static major?  For funky hardware like the
Doubletalk for which the number of Linux users worldwide can probably be
counted on your fingers you can just grep /proc/devices for its allocated
major and create the /dev node on the fly.


Nicolas

