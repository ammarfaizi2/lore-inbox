Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423012AbWAMWO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423012AbWAMWO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWAMWO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:14:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:8586 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423012AbWAMWOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:14:24 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dtor_core@ameritech.net
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
References: <20051225212041.GA6094@hansmi.ch>
	 <1137022900.5138.66.camel@localhost.localdomain>
	 <20060112000830.GB10142@hansmi.ch>
	 <200601122312.05210.dtor_core@ameritech.net>
	 <1137189319.4854.12.camel@localhost.localdomain>
	 <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 09:14:04 +1100
Message-Id: <1137190444.4854.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
> or just "fnkeyfirst and fnkeyast"?

I think "no translation" should still be around if people want to handle
it entirely from userland no ?

That is:

 - no translation : nothing special is done, Fx sends Fx keycode
regardless of Fn key, Fn key itsef sends a keycode for itself, there is
no emulation of numlock

 - fnkeyfirst / fnkeylast : Either Fx is translated and Fn-Fx is not or
the opposite. Numlock emulation is enabled.

> Huh? You mean 1, right?

Yah, forget it, I was on crack.


