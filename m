Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUAJUXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUAJUXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:23:54 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:61866 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265370AbUAJUXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:23:49 -0500
Date: Sat, 10 Jan 2004 21:23:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110202348.GA23318@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz> <20040110194420.GA1212@elf.ucw.cz> <20040110195531.GD22654@ucw.cz> <6u1xq77e29.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6u1xq77e29.fsf@zork.zork.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 08:18:22PM +0000, Sean Neakums wrote:

> > Well, if you need to boot both 2.6 and 2.4 _and_ need to use gpm and X
> > in parallel _and_ need tap-to-click in both gpm and X, then you have to
> > use the kernel command line parameter and put your synaptics into legacy
> > mode.
> 
> Using psmouse_proto=imps?  Or something else?

Yes, that one.

> Will this also result in the passthough port not being enabled?
> (I'd like to disable it.)

It depends on the touchpad firmware. Most leave it enabled.
In this mode we don't have any control over the passthrough port.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
