Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUGWKyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUGWKyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267621AbUGWKyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:54:15 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:64680 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S267619AbUGWKyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:54:13 -0400
Subject: Re: User-space Keyboard input?
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Lang <mlang@delysid.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87y8lb80yj.fsf@lexx.delysid.org>
References: <87y8lb80yj.fsf@lexx.delysid.org>
Content-Type: text/plain
Message-Id: <1090580051.4791.24.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 12:54:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

> I'm working on BRLTTY[1], a user-space daemon which handles braille displays
> on UNIX platforms.  One of our display drivers recently gained the ability
> to receive (set 2) scancodes from a keyboard connected directly to the display.
> This is a very cool feature, since the display in question has
> a bluetooth interface, making it effectively into a complete wireless
> terminal (input and output through the same connection).

tell me more about this Bluetooth device.

> However, this creates some problems.  First of all, we now have to deal
> with keyboard layouts.  Additionally, since we currently insert via
> TIOCSTI I think this might get problematic as soon as one switches
> to an X Windows console and modifiers come into play.
> 
> Does anyone know (and can point me into the right direction) if
> Linux has some mechanism to allow for user-space keyboard data to
> be processed by the kernel as if it were received from the system
> keyboard?  I.e., keyboard layout would be handled by the same
> mapping which is configured for the system.

Take a look at the user level driver support (uinput).

Regards

Marcel


