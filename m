Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUDOTrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDOTrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:47:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:50560 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263142AbUDOTr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:47:29 -0400
Date: Thu, 15 Apr 2004 21:47:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>, Grzegorz Kulewski <kangur@polcom.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Message-ID: <20040415194748.GB3903@ucw.cz>
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <200404071321.01520.rjwysocki@sisk.pl> <20040407113004.GA2574@ucw.cz> <20040415185414.GF18971@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415185414.GF18971@charite.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 08:54:14PM +0200, Ralf Hildebrandt wrote:
> * Vojtech Pavlik <vojtech@suse.cz>:
> 
> > > Look, I've been using different variants of the 2.6.x kernels on this very 
> > > machine/distro since early 2.6.0-test and I hadn't seen _anything_ like this 
> > > before 2.6.5-rc2 (then I saw something like this first).  I _really_ don't 
> > > think it's a distribution-related issue.
> > 
> > Maybe you could enable debugging in i8042.c, and look at the log around
> > the unexpected reconnect of the keyboard.
> 
> How? Enlighten us...

Edit i8042.c, #define DEBUG.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
