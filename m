Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWAADDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWAADDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 22:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWAADDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 22:03:34 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:59420 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932184AbWAADDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 22:03:33 -0500
Date: Sun, 1 Jan 2006 04:03:31 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060101030331.GA26559@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <20051231235124.GA18506@hansmi.ch> <1136084207.4635.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136084207.4635.86.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 01:56:47PM +1100, Benjamin Herrenschmidt wrote:
> I've been using the other patch for some time now and while it's a
> life-saver, it does have one annoying little issue: If you press a key
> with the Fn key down and release that key with the Fn key up, your key
> is stuck.

I noticed something like that with the numlock key as well but didn't
have time to fix it yet.

Other than that, have you found any keys that aren't mapped or are
mapped incorrectly?

The new patch adds quite some code to hid-input.c, should it be
configuratible via .config?

Thanks,
Michael
