Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVGDNmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVGDNmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVGDNma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:42:30 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:21143 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261719AbVGDNUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:20:20 -0400
Date: Mon, 4 Jul 2005 15:20:14 +0200
From: =?ISO-8859-1?B?Q/R06Q==?= Alexandre <alialex@free.fr>
To: linux-kernel@vger.kernel.org
Message-ID: <20050704152014.06424fe4@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.6cvs1 (GTK+ 2.6.8; i386-pc-linux-gnu)
X-Face: _KCW>Ke#s){r1"2b/Zt&1p,A@;J"URCwvAJT=6%ch?q%qalK"in~{-J@m/ZNxrP=i8ssyTz
 oP?RkUy1L6\NF{R;ff9S<"Y`Gzk09A3_]0/SW{0eIY@HU>*2}EN=,yoxzQgpO=l@:4;TuD%/`_HZA9
 X,5pY~xHA8s*bla1?Qfr%@$wk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: alialex@free.fr
Subject: psmouse, proto
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on localhost.localdomain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel : 2.6.11 from kernel-tree 2.6.11-7 on debian  sid

psmouse module install automatically when booting the system (nothing write in /etc/modules, don't know why it's now automatically install) and dmesg says
input: ImExPS/2 Logitech explorer mouse on isa0060/serio1

everythings good
but the middle button (button 2) doesn't work (nothing with xev)

if I rmmod psmouse and then
modprobe psmouse proto=exps

then dmesg says

input: ImExPS/2 Generic explorer mouse on isa0060/serio1

and then my mouse works good, the button 2 works.

I send this just for information.

PS: it looks like the serio1 is my keyboard and that the mouse is on serio0.

