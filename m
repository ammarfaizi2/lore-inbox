Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTEJSWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTEJSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 14:22:39 -0400
Received: from bastion0.paxonet.com ([209.172.126.232]:31502 "EHLO
	mail.paxonet.com") by vger.kernel.org with ESMTP id S264465AbTEJSWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 14:22:38 -0400
Date: Sat, 10 May 2003 11:35:19 -0700 (PDT)
From: Simon Matthews <simon@paxonet.com>
X-X-Sender: simon@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Problems with DRM/R128
Message-ID: <Pine.LNX.4.44.0305101124230.8905-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ATI Rage 128. I am using the 2.4.20 vanilla kernel. I have 
compiled in the DRM 4.1 and the R128 driver (not as modules, but part of 
the kernel). 

However, graphics such as tuxracer are very slow. The XFree86 log file 
shows an entry:
(II) R128(0): [drm] Added 128 16384 byte vertex/indirect buffers
(II) R128(0): [drm] Mapped 128 vertex/indirect buffers
(II) R128(0): [drm] failure adding irq handler, there is a device already 
using that irq
[drm] falling back to irq-free operation
(II) R128(0): Direct rendering enabled
 
On starting OpenOffice, I see: 
 ooffice
Gnome session manager detected - session management disabled
running openoffice.org setup...
Setup complete.  Running openoffice.org...
libGL error: failed to open DRM: Operation not permitted
libGL error: reverting to (slow) indirect rendering
 
Now I am pretty sure this is a kernel-related issue, since in the past on
the same hardware with a Redhat 7.3 distro (I am now using gentoo), I
observed that tuxracer was very slow when using the vanilla kernel, but if
I installed the RedHat kernel, it worked fine.

Can anyone please suggest how I can fix this? 
 
Many thanks!
Simon

