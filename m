Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVADQjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVADQjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVADQjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:39:36 -0500
Received: from styx.suse.cz ([82.119.242.94]:17110 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261705AbVADQj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:39:27 -0500
Date: Tue, 4 Jan 2005 17:40:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050104164025.GA13240@ucw.cz>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org> <20050104135859.GA9167@ucw.cz> <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org> <20050104160830.GA13125@ucw.cz> <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:14:52AM -0800, Linus Torvalds wrote:

> On Tue, 4 Jan 2005, Vojtech Pavlik wrote:
> > 
> > I can hide it, the reasoning was that it may be useful for out-of-kernel
> > modules, and because of that it's possible to enable it even when there
> > are no users, and only then it's an option.
> > 
> > atkbd and psmouse do "select" it.
> 
> Ok, that seems fine. I'll hide it behind "EMBEDDED" at least until 
> somebody actually has an out-of-tree user on any platform where it makes 
> any sense (on a PC it will be enabled _anyway_ by the kbd/mouse thing, and 
> on anything else I don't see it making any sense anyway, and it clearly 
> only confuses people - since it confused me).

Ok.

> > > So it has been part of the -mm tree? Good.
> > 
> > Yes.
> 
> Ok. I'll re-pull and make it embedded to make that irritating question go 
> away.
 
Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
