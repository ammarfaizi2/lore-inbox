Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUDESLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUDESLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:11:49 -0400
Received: from gprs214-233.eurotel.cz ([160.218.214.233]:4739 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263041AbUDESLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:11:47 -0400
Date: Mon, 5 Apr 2004 20:11:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] PS/2 strict protocol checking and reconnect for KVM users
Message-ID: <20040405181136.GA11520@elf.ucw.cz>
References: <200403230157.47800.dtor_core@ameritech.net> <20040323080122.GA277@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323080122.GA277@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have some ideas about a statistical synchronizer for the PS/2, ImPS/2
> and ExPS/2 protocol. There is IMO no way to recognize the PS2++ vs PS/2
> change.
> 
> The X and Y values are usually < 8, the buttons are usually not pressed,
> etc. From that and the interbyte timing one should be able to guess
> whether he sees a 3-byte per packet or 4-byte per packet protocol after
> a few packets, and also where the packets start.

That sounds pretty crazy... I'd expect use to be more reliable than
speech recognition ;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
