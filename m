Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUAKQbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAKQbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:31:04 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:44958 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S265233AbUAKQbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:31:02 -0500
Date: Sun, 11 Jan 2004 17:30:50 +0100
From: Eduard Bloch <edi@gmx.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: bad scancode for USB keyboard
Message-ID: <20040111163050.GA28671@zombie.inka.de>
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com> <20040107085104.GA14771@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040107085104.GA14771@ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailgate1.uni-kl.de id i0BGV0f4007207
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Vojtech Pavlik [Wed, Jan 07 2004, 09:51:04AM]:

> The reason is that this key is not the ordinary backslash-bar key, it's
> the so-called 103rd key on some european keyboards. It generates a
> different scancode.

Fine, but there are a lot of USB keyboard that _work_ that way, where
the "103rd" key is really positioned as the one and the only one '# key.
And the current stable X release does NOT know about the new scancode.
You realize that you intentionaly broke compatibility within a stable
kernel release?

> 2.4 used the same keycode for both the scancodes, 2.6 does not, so that
> it's possible to differentiate between the keys on keyboards that have
> both this one and also the standard backslash-bar.

*May* be a nice feature, but such things require better planning.

Regards,
Eduard (going to revert that change before compiling 2.6.1 now).
-- 
Am Abend manche Hülle fällt, die sonst des Leibes Fülle hält.
