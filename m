Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUKCAkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUKCAkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUKBWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:23:04 -0500
Received: from c-24-10-162-127.client.comcast.net ([24.10.162.127]:54657 "EHLO
	zedd.willden.org") by vger.kernel.org with ESMTP id S262065AbUKBWSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:18:15 -0500
From: Shawn Willden <shawn@willden.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8 Thinkpad T40, clock running too fast
Date: Tue, 2 Nov 2004 15:18:12 -0700
User-Agent: KMail/1.7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021518.17391.shawn@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm having a problem with the clock on my Thinkpad running too fast.  My clock 
is gaining about 4 seconds every five minutes of operation.  I'm actually not 
sure when this started because NTP has been fairly successful at keeping my 
clock under control, so I didn't really notice it until I spent some time 
operating disconnected... and then it became very obvious very quickly.

On October 15th, I "fixed" the problem by booting with "noapic" on the command 
line.  Or I thought I fixed it anyway.  I had to reboot yesterday for an 
unrelated issue (a "stuck" smb share that I couldn't figure out how to 
unmount) and the racing clock is back.  I've booted with "noapic", "nolapic", 
"noapic nolapic" and no options at all, and the clock doesn't keep the time 
with any of them.  I'm not sure if it's always too fast.  I seem to remember 
that last month it was running too slow.  I'll check with the various apic 
settings and see if it's consistent.

I'm not sure what information I need to provide, but you can find my kernel 
config at http://willden.org/~shawn/config-2.6.8.  It's built from the Debian 
2.6.8 tree, with a custom config.  The CPU is a 1.6GHz Pentium M in a 
"Centrino" chipset.

What should I be looking at to track this down?  I'm building a 2.6.9 kernel 
but I haven't found any reports of similar problems corrected by it, so I 
don't expect that to make a difference.

Thanks,

 Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBiAep6d8WxFy/CWcRAoXVAKCeEwysrrF/+lcFuRttAx5JDs8RYQCgjf1q
cdK/581EqaX+2oGXlkOLpoE=
=sNMu
-----END PGP SIGNATURE-----
