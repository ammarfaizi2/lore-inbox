Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTJGUdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTJGUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:33:47 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:18439 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262769AbTJGUdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:33:45 -0400
Date: Tue, 7 Oct 2003 22:33:16 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: keyboard repeat speed went nuts since 2.6.0-test5, even in 2.6.0-test6-mm4
Message-ID: <20031007203316.GA1719@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like my keyboard fast (must be from playing a lot of angband).

In 2.6.0-test5, after '/sbin/kbdrate -r 30 -d 250', I get some 2000
characters in a minute (pressing n continuously, stopwatch in hand).
In 2.6.0-test6 and 2.6.0-test6-mm4, after '/sbin/kbdrate -r 30 -d 250',
I get some 820 characters in a minute.

30 cps != 800/60 s, that's more like half that rate.

Booting with or without atkbd_softrepeat=1 on the kernel commandline
makes no difference at all.

It's not only the repeat-speed that has gone down, the delay before
repeat kicks in is notably slower as well. This is perhaps even more
frustrating, but harder to measure :-(

This is on a plain Chicony KB-7903 PS/2 keyboard. It is connected via a
Vista Rose KVM to a VIA KT400 chipset motherboard.

Any patches to test are very welcome here.

Thanks,
Jurriaan
-- 
She'd put a lot of work and practice into that glare, and it had always
served her well in the past. It suggested she was one hundred percent
crazy, barely under control, and violent with it.
	Simon R Green - Guard against Dishonour
Debian (Unstable) GNU/Linux 2.6.0-test5 4276 bogomips 0.33 0.14
