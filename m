Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWARVUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWARVUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWARVUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:20:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:37643 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030473AbWARVUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:20:37 -0500
Date: Wed, 18 Jan 2006 22:20:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118212022.GA15828@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org> <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr> <20060118191247.62cc52cd.khali@linux-fr.org> <20060118203231.GA14340@mars.ravnborg.org> <1137617677.4757.90.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137617677.4757.90.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:54:37PM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-01-18 at 21:32 +0100, Sam Ravnborg wrote:
> 
> > But in the lxdialog case we need to execute the link step, because
> > what we really try to do is to check if gcc can find a specific
> > library in the search path.
> 
> Will -print-file-name not do the trick for you?
> 
> $ gcc -print-file-name=libcurses.so | grep -q /
> $ echo $?
> 0
> $ gcc -print-file-name=libfoobar.a | grep -q /
> $ echo $?
> 1
Much better - thanks!
I will push out a new path tomorrow.

	Sam
