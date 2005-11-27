Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVK0Dbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVK0Dbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 22:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVK0Dbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 22:31:37 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:53666 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750832AbVK0Dbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 22:31:36 -0500
Message-ID: <43892897.9020900@vc.cvut.cz>
Date: Sun, 27 Nov 2005 04:31:35 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab wrote:
> Hi,
> 
> on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load 
> (like during kernel compilation for instance, or any compilation of any 
> bigger project, for that matter), I hear some beeps comming out of the PC 
> speaker. It's like few short beeps per second for a while, then silence 
> for few seconds, then a beep here and there, and again, and so on. It is 
> quite strange. It happens ever since I remember (I mean in kernel 
> versions of course, I have the board for about 1.5 years). I've just been 
> kind of ignoring it until now. Does anybody else happen to see the same 
> symptoms? What could be the cause of this. Is it something about timing? 
> But how come the PC speaker gets kiced in, while it's not being used at 
> all (well, at least not intentionally) for anything. Perhaps something is 
> writing some ports it is not supposed to?

Nope.  Your system is overheating, and on-board temperature sensors are 
complaining.  Probably you should find whether lm-sensors have drivers for chips 
your motherboard has, and look at sensors output in that case...

Maybe ACPI could report thermal zone as well, try looking at 
/proc/acpi/thermal_zone/* tree.
								Petr

