Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWAKViJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWAKViJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAKViI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:38:08 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:48156 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750825AbWAKViH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:38:07 -0500
Date: Wed, 11 Jan 2006 22:38:05 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060111213805.GE6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <1135575997.14160.4.camel@localhost.localdomain> <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com> <20060111212056.GC6617@hansmi.ch> <1137015258.5138.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137015258.5138.20.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 08:34:17AM +1100, Benjamin Herrenschmidt wrote:
> Yeah, but the question is why 3 ? I think one (on/off) is enough. Do you
> have any case where people actually change the other ones ?

Johannes Berg told me he wants to use the fn key alone to switch the
keyboard layout or something. For such uses, the pb_enablefn is there.
pb_fkeyslast is to emulate the behaviour of KBDMode from pbbuttonsd.
The last one, pb_disablekeypad could left out. It doesn't add much code
and might be used by some people, too.

Greets,
Michael
