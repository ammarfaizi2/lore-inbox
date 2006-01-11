Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWAKVny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWAKVny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWAKVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:43:54 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:22813 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750866AbWAKVnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:43:53 -0500
Date: Wed, 11 Jan 2006 22:43:51 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060111214351.GF6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <1135575997.14160.4.camel@localhost.localdomain> <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com> <20060111212056.GC6617@hansmi.ch> <1137015258.5138.20.camel@localhost.localdomain> <20060111213805.GE6617@hansmi.ch> <1137015669.5138.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137015669.5138.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 08:41:08AM +1100, Benjamin Herrenschmidt wrote:
> > Johannes Berg told me he wants to use the fn key alone to switch the
> > keyboard layout or something. For such uses, the pb_enablefn is there.

Sorry, actually it's called pb_disablefn now.

> What does it do ? Just send a keycode ? That should be unconditionnal.
> The Fn key should change a keycode always. I don't see why you would
> that to be off.

No, if that parameter is disabled, it translates key combinations like
Fn+F1 to KEY_BRIGHTNESSUP. If it's enabled, it only sends KEY_FN.

Greets,
Michael
