Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUGXGIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUGXGIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUGXGIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:08:43 -0400
Received: from viefep12-int.chello.at ([213.46.255.25]:38701 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S268310AbUGXGIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:08:38 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: User-space Keyboard input?
From: Mario Lang <mlang@delysid.org>
In-Reply-To: <20040724010256.GA3757@bouh.is-a-geek.org> (Samuel Thibault's
 message of "Sat, 24 Jul 2004 03:02:57 +0200")
References: <87y8lb80yj.fsf@lexx.delysid.org>
	<20040724010256.GA3757@bouh.is-a-geek.org>
Date: Sat, 24 Jul 2004 08:09:17 +0200
Message-ID: <87llhahr76.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> About modifiers, I submitted a patch to Dave to handle them
> properly.
>
> But ascii to scancode translation still depends on scancode to ascii
> translation performed by the kernel indeed and the question still
> applies. I'll have a look at uinput.

uinput support is now committed to scr_linux.c.  I am using the exernal
keyboard of my bluetooth capable braille display to type this email already
via uinput :-).  The same layout is used as is configured on the box.
Our generic AT2 support maps to VAL_PASSKEY commands and
the AT2 support for Linux maps the AT2 scancode set to what Linux internally
uses for scancodes (a sort of XT scancode set, but not really).


-- 
CYa,
  Mario
