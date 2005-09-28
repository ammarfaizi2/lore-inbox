Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVI1OR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVI1OR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 10:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVI1OR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 10:17:58 -0400
Received: from main.gmane.org ([80.91.229.2]:41919 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750999AbVI1OR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 10:17:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Blanky rivafb vs snowy nvidiafb with 2.6.12
Date: Wed, 28 Sep 2005 16:12:07 +0200
Message-ID: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-19-69.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a Dell Inspiron 8200 with an nVidia GeForce2 Go video card.
There are currently two Linux kerenl framebuffer drivers that I can
try to use (rivafb and nvidiafb) but they both have issues:

* rivafb works when compiled in, but not when compiled as a module: in
the latter case, as soon as the fb is touched (even just by a fbset
-i) the screen goes unrecoverably blank, although the computer is
still usable (blindly). Interestingly, enabling the very verbose debug
output allows the module to work, but as soon as scrolling beings the
screen is continuously filled by the (very verbose) debug output and
scrolls on forever.

* I have thus tried the new nvidiafb driver, which seems to work ok,
except for the minor detail that the display is extremely snowy.
Attempts to change the timing options with fbset fail: fbset seems to
accept the settings, no error message is given, but nothing is
changed. The X nv driver select the correct timings, so I tried
modeline2fb to make fbset use those, but still nothing changes.

Any suggestions?

-- 
Giuseppe "Oblomov" Bilotta

"They that can give up essential liberty to obtain
a little temporary safety deserve neither liberty
nor safety." Benjamin Franklin

