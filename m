Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUGTM5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUGTM5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUGTM5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:57:16 -0400
Received: from ip47-168.ott.istop.com ([66.11.168.47]:16256 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S264966AbUGTM5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:57:07 -0400
Date: Tue, 20 Jul 2004 14:58:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
Message-ID: <20040720125802.GA395@ucw.cz>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com> <20040719200608.280d17a1@lembas.zaitcev.lan> <20040720051353.GD313@ucw.cz> <20040719225104.7defc877@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719225104.7defc877@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 10:51:04PM -0700, Pete Zaitcev wrote:

> On Tue, 20 Jul 2004 07:13:53 +0200
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > Actually USB Legacy SMM emulation triggers problems on many many more
> > systems. The quirk does exactly the same thing the USB HCI drivers do in
> > their init code, it only does it early in the boot process, so that
> > even if the USB drivers are modules, the i8042 controller and PS/2 mouse
> > and keyboard initialization proceeds correctly.
> 
> I guessed it, but I hoped it wasn't "many more systems", but rather
> "a few", so matching would made sense.
> 
> It would be comforting to know that we ran this in 2.6 or elsewhere
> before recommending it for Marcelo. Did you guys actually ship it
> with SLES or something? For how long?

It's being shipped in SL9.1 and SLES9, since may. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
