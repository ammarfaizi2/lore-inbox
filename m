Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSGGOjX>; Sun, 7 Jul 2002 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSGGOjW>; Sun, 7 Jul 2002 10:39:22 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:11278 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315942AbSGGOjW>;
	Sun, 7 Jul 2002 10:39:22 -0400
Message-ID: <3D28531D.D486855@torque.net>
Date: Sun, 07 Jul 2002 10:41:33 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wheel mouse scrolls backwards in lk 2.5.25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported the same behaviour when the "input" stuff
was in Dave Jones's tree: the wheel on my "logitech"
PS/2 mouse now scrolls panes the wrong way (or at
least the opposite way to 2.5.24 and windows).

Here are the mouse related lines from /var/log/messages :
Jul  7 09:56:25 frig kernel: mice: PS/2 mouse device common for all mice
....
Jul  7 09:56:25 frig kernel: input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1  
Jul  7 09:56:25 frig kernel: serio: i8042 AUX port at 0x60,0x64 irq 12

Doug Gilbert
