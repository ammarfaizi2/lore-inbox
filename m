Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUCKTZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCKTZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:25:14 -0500
Received: from pina-colada.ucf.ics.uci.edu ([128.195.23.7]:45577 "EHLO
	pina-colada.ucf.ics.uci.edu") by vger.kernel.org with ESMTP
	id S261498AbUCKTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:25:07 -0500
Date: Thu, 11 Mar 2004 11:25:07 -0800 (PST)
From: Edmund Lau <edlau@ucf.ics.uci.edu>
To: linux-kernel@vger.kernel.org
Subject: pts bug? and keyboard on kvm
Message-ID: <Pine.LNX.4.58.0403111109290.21406@pina-colada.ucf.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I just upgraded to 2.6.4.  Is it normal for /dev/pts numbers to keep
increasing now?  With 2.6.3, I could log in or create an xterm and a pts
would be assigned.  Then when it was released, another process could reuse
that number.  Now, it seems it just keeps incrementing.  Has this changed?
I'm still using the legacy pty count option (256), if that matters.

Secondly, I have a regular 101-Keyboard attached through a Belkin KVM.
Upon booting in 2.6 (and into XFree86 4.2.1) the keyboard doesn't respond.
It never happened in the 2.4 series.  I can get around this by hitting
Control, Shift, Alt and the like during bootup and when it finally loads
the X login screen it works just fine.  Do I need to update my
xfree86.conf file?  Is there a kernel boot option I should be passing in?
I had crazy mouse action before I added "psmouse.proto=imps" to my kernel
boot options.

Let me know if anyone needs more info.

Thanks,
-Ed
