Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUBJULw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUBJULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:11:15 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:896 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264477AbUBJULE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:11:04 -0500
Date: Tue, 10 Feb 2004 21:11:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: console/gpm mouse breakage 2.6.3-rc1-mm1
Message-ID: <20040210201102.GB261@ucw.cz>
References: <200402100605.25115.tabris@tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402100605.25115.tabris@tabris.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 06:05:19AM -0500, tabris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 	just went to 2.6.3 this morning due to frustrations with my PDC20265 causing 
> lockups... hoping that 2.6 solves this problem...
> 
> 	and now i'm having trouble where gpm doesn't work right... cilcks don't 
> register as a click event. Yes, it works fine in X (using GPM in repeater 
> mode, -R raw. the old hack I used to allow X to use both mice, as well as 
> eliminating the gpm crashes every couple times I switched btwn X and console 
> mode.)
> 
> instead I get characters echoed to my terminal
> left click: Q
> right click: W
> middle click: E (plus some control character... i haven't tried a capture and 
> hexdump yet)
> 
> 	also, my PS/2 mouse (MS IMPS/2) no longer works. from any /dev node I've 
> tried.

This is very interesting. Can you post your /proc/bus/input/devices and
dmesg?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
