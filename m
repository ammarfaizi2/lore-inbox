Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQLOX7P>; Fri, 15 Dec 2000 18:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQLOX7G>; Fri, 15 Dec 2000 18:59:06 -0500
Received: from m35-mp1-cvx1c.col.ntl.com ([213.104.76.35]:6404 "EHLO
	[213.104.76.35]") by vger.kernel.org with ESMTP id <S129423AbQLOX6z>;
	Fri, 15 Dec 2000 18:58:55 -0500
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: DPMS kicks in at the wrong time
In-Reply-To: <200012130649.eBD6mcZ02368@emu.os2.ami.com.au>
From: "John Fremlin" <vii@penguinpowered.com>
Date: 15 Dec 2000 19:56:35 +0000
In-Reply-To: John Summerfield's message of "Wed, 13 Dec 2000 14:48:47 +0800"
Message-ID: <m2snnp791o.fsf@localhost.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 John Summerfield <summer@OS2.ami.com.au> writes:

[...]

> 3) When I then switch back to a virtual console, the screen blanks
> and switches to power-saving mode.

Which powersave mode? There are three, IIRC. You can tell them apart
by the color of or whether the light blinks on some monitors.

If the monitor is set to a modeline that it knows is crazy it might
turn itself off automatically instead of trying to display it. That
is, the framebuffer driver or XFree86 is probably not reseting some
values it should.

[...]

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
