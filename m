Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUDGL36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUDGL36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:29:58 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:46211 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263007AbUDGL3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:29:55 -0400
Date: Wed, 7 Apr 2004 13:30:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Message-ID: <20040407113004.GA2574@ucw.cz>
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <200404071321.01520.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404071321.01520.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:21:01PM +0200, R. J. Wysocki wrote:

> > Or use different distribution than RH9. They often modify gcc and other
> > programs, maybe even X - maybe try to compile your kernel on "vanilla" gcc
> > 3.3.3. I can give you a shell on computer with Gentoo and working gcc. Or
> > change distribution: Gentoo works ok for me and my friends! :-)
> 
> Look, I've been using different variants of the 2.6.x kernels on this very 
> machine/distro since early 2.6.0-test and I hadn't seen _anything_ like this 
> before 2.6.5-rc2 (then I saw something like this first).  I _really_ don't 
> think it's a distribution-related issue.

Maybe you could enable debugging in i8042.c, and look at the log around
the unexpected reconnect of the keyboard.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
