Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSKGNll>; Thu, 7 Nov 2002 08:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266556AbSKGNll>; Thu, 7 Nov 2002 08:41:41 -0500
Received: from signup.localnet.com ([207.251.201.46]:45536 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S266555AbSKGNlk>;
	Thu, 7 Nov 2002 08:41:40 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: 2.5 bk, input driver and dell i8100 nib+pad
References: <m3el9xk7uv.fsf@lugabout.jhcloos.org>
	<m3k7jqj9mi.fsf@lugabout.jhcloos.org>
	<m3n0omk97i.fsf@lugabout.jhcloos.org>
	<11033.1036602261@passion.cambridge.redhat.com>
	<5339.1036653369@passion.cambridge.redhat.com>
	<12249.1036665016@passion.cambridge.redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <12249.1036665016@passion.cambridge.redhat.com>
Date: 07 Nov 2002 08:48:07 -0500
Message-ID: <m38z05jxt4.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

David> Weird. Does it come back to life if you suspend to RAM and
David> resume? Does the 'mouse' get detected as a Synaptics Touchpad
David> by the changed psmouse.c?

I have to do a new compile with the csets from overnight for the htree
bug before I can test that.  But from /var/log I see:

    kernel: input: PS/2 Synaptics TouchPad on isa0060/serio1

with the patch and w/o the patch I had:

    kernel: input: PS/2 Generic Mouse on isa0060/serio1

so that part of it at least was fixed.

-JimC

