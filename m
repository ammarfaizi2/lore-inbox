Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbTBQOtn>; Mon, 17 Feb 2003 09:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTBQOtn>; Mon, 17 Feb 2003 09:49:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:787 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267426AbTBQOsg>;
	Mon, 17 Feb 2003 09:48:36 -0500
Date: Mon, 17 Feb 2003 15:58:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (8/26) core
Message-ID: <20030217145834.GB3729@mars.ravnborg.org>
Mail-Followup-To: Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217140722.GH4799@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217140722.GH4799@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 11:07:22PM +0900, Osamu Tomita wrote:
> This is patchset to support NEC PC-9800 subarchitecture
> against 2.5.61 (8/26).

Browsing the code resulted in a few comments:
this code does at least the following:
1) introducing more sensible names for some constants
2) Moving functionality to mach-default
3) Adding PC9800 functionality

I suggest splitting up the patch in more sensible chunks, and get 1) and 2) applied first.

	Sam
