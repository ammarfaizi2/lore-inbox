Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbTDFPNl (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTDFPNk (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:13:40 -0400
Received: from AMarseille-201-1-5-206.abo.wanadoo.fr ([217.128.250.206]:55847
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262998AbTDFPNh (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:13:37 -0400
Subject: [PATCH] New radeonfb fork
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049642954.550.41.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Apr 2003 17:29:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

As I told a while ago, I'm forking radeonfb for now, at least
until Ani (current maintainer) either give me maintainership
or gets all that stuff in the official version.

I need testers, and I'd appreciate any patches people may have
for it as well since I know a bunch of ppl have been spreading
various radeonfb patches around, I want to take over all of these
and see what is worth getting in. For 2.5, I'm working on a
complete rewrite (& split) of the driver.

So far, I already have something to play with that fixes a
bunch of issues. Patches against 2.4.20 and 2.4.21-pre7 can
be found here: (too big to inline). Note that I also bring
in various other pci_ids.h updates but that shouldn't harm
you and is easier that way for me ;)

http://penguinppc.org/~benh/radeonfb-040603-2.4.20.diff
http://penguinppc.org/~benh/radeonfb-040603-2.4.21-pre7.diff

NOTE: It's known that radeonfb is incompatible with ATI binary
GL drivers (at least it crashes the machine on a friend's r300),
I'm investigating.

Ben.


