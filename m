Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSHVSfw>; Thu, 22 Aug 2002 14:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSHVSfw>; Thu, 22 Aug 2002 14:35:52 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:50656 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315607AbSHVSfv>; Thu, 22 Aug 2002 14:35:51 -0400
Date: Thu, 22 Aug 2002 11:34:38 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] broken cfb* support in the 
In-Reply-To: <212B36E116D@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0208221132230.9077-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Which new API?

The one being worked on for the last 2 years.

> If you are going to remove logo and unaccelerated fbcon-cfb*,
> then remove them completely. If you are not going to remove unaccelerated
> fbcon-cfb*, then there is no reason for breaking them.

The next set of round of changes will will reimplement drawing the penguin
and will support 24 bpp mode. So we will be able to remove fbcon-cfb*
completely the next round.

> I'm not going to remove unaccelerated code from the matroxfb. Never.

Then implement your own soft accel functions.

