Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJUJqK>; Sun, 21 Oct 2001 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJUJqB>; Sun, 21 Oct 2001 05:46:01 -0400
Received: from [216.133.167.123] ([216.133.167.123]:12556 "EHLO foozle.jmd")
	by vger.kernel.org with ESMTP id <S275743AbRJUJpx>;
	Sun, 21 Oct 2001 05:45:53 -0400
Date: Sun, 21 Oct 2001 04:46:30 -0500
From: "Jeremy M. Dolan" <jmd@pobox.com>
To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: severe ns558 joystick problems with 2.4.12
Message-ID: <20011021044630.A745@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted to linux-kernel 10 days ago with this problem, didn't really
get any follow up, except other users having the same problem. So far
have had 6 users contact me with the same problem, seems to have
occured as early as 2.4.9 and .10, based on what I've heard from others.

To recap:

I have a 2 axis 6 button analog (ns558) gamepad. With 2.4.7,
everything is fine, as long as I pass js=gamepad, it detects the 2
axis and 6 buttons.

With 2.4.12, with js=gamepad and js=12531 (bitfield forced detection),
the kernel message SAYS it detects 2 axis and 6 buttons, however when
I use it (for example, with the jstest program), the two axis and
buttons 4/5 don't register. The first four (0-3) buttons are fine.

-- 
Jeremy M. Dolan <mailto:jmd@pobox.com> <http://turbogeek.org/>
PGP: 1024D/DC433DEE 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
