Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267464AbSKQH5Z>; Sun, 17 Nov 2002 02:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbSKQH5Z>; Sun, 17 Nov 2002 02:57:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36619 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267464AbSKQH5Y>; Sun, 17 Nov 2002 02:57:24 -0500
Date: Sun, 17 Nov 2002 02:49:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <20021115212517.GA10080@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.96.1021117024753.18748B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Sam Ravnborg wrote:

> Here is first try:
> - clean now deletes all generated files except .config + .config.old
> - mrproper in addition to clean only deleted .config + .config.old
> - distclean in addition ot mrproper deletes backupfiles as usual.

Just what I wanted. If you can be happy doing this it now provides all
three useful behaviours in a clear manner.

Good show!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

