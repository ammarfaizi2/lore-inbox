Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbSLCVTW>; Tue, 3 Dec 2002 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSLCVTW>; Tue, 3 Dec 2002 16:19:22 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:44972 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266274AbSLCVTV>; Tue, 3 Dec 2002 16:19:21 -0500
Date: Tue, 3 Dec 2002 14:18:59 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
In-Reply-To: <1038918094.1225.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212031417520.10097-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a patch against linux-2.5.50 + your fbdev.diff.

Applied :-)

> b.  Another rewrite of fbcon_show_logo() so it's more understandable
> (hopefully).  I also added support for the rest of the visuals, but
> untested yet.
> Not tested:
> static psuedocolor, mono01, and mono10.

I have a mono hga card.

> c.  prevent fbcon module from loading if no fbdev is registered.  Also
> made fbcon module unsafe to unload (for now).  This is optional, of course.

It is a good idea until we have the ability to switch back to text mode.


