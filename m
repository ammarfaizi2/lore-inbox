Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282991AbRLDAVB>; Mon, 3 Dec 2001 19:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284711AbRLDAPw>; Mon, 3 Dec 2001 19:15:52 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:5381 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S284594AbRLCOPe>;
	Mon, 3 Dec 2001 09:15:34 -0500
Subject: thinkpad t21 lockup when using pcmcia package
From: Shaya Potter <spotter@cs.columbia.edu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 03 Dec 2001 09:15:04 -0500
Message-Id: <1007388908.974.0.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have narrowed down my lockups to when I use a recent 2.4
kernel (currently on 2.4.15-pre8) and the external pcmcia source
(currently have 3.1.29 on my system).  The main reason I use the pcmcia
source is that I can't get my orinoco card to work with the kernel's
modules, though it works out of the box with the pcmcia source.

The problem I'm having is that if I leave my laptop on overnight (with
the (kernel + pcmcia package combo) it locks up sometime during the
night after a few hours of inactivity on console.  If I leave an ssh
session into it doing stuff it still locks up.  However, if I apm
--suspend it.  It surives the night fine.  It also seems to survive find
if I use the built into kernel pcmcia package.

As this is just a case of "hanging" and there's no messages in syslog on
reboot, anybody have any clues on how to diagnore this, and fix this
(and I'd personally think that understanding how to get my orinoco card
to work with the in kernel source drivers to be a fix)

thanks,

shaya
-- 
spotter@{cs.columbia.edu,yucs.org}
http://yucs.org/~spotter/

