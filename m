Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBPNlq>; Fri, 16 Feb 2001 08:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRBPNlg>; Fri, 16 Feb 2001 08:41:36 -0500
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:24583 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S129111AbRBPNl1>; Fri, 16 Feb 2001 08:41:27 -0500
From: bvermeul@devel.blackstar.nl
Date: Fri, 16 Feb 2001 14:41:24 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: [2.4.2-pre3] Slow XFree 4.0.2 with DRI/DRM enabled
Message-ID: <Pine.LNX.4.21.0102161431210.10542-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having some problems with XFree86 4.0.2 and DRI/DRM in 2.4.2-pre3.
I'm using a Dell Inspiron 8000 with a ATI Rage Mobility M4 32 MB,
and can get it running with DRI under 2.4.0-ac10. When using 2.4.2-pre3, I
can see each individual widget being built when I enable DRI.

output lspci -v:

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
4d46 (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00a4
        Flags: bus master, VGA palette snoop, stepping, 66Mhz, medium
devsel, latency 32, IRQ 11
        Memory at e8000000 (32-bit, prefetchable) [size=64M]
        I/O ports at cc00 [size=256]
        Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2

Busmastering was enabled with setpci. To use DRI, bus master has to be
enabled.

DRI with 2.4.0-ac10 works like a charm (nice performance), but 2.4.2-pre3
lets me view each widget part being built when I enable DRI.

Anyone got any ideas? I've tried using 2.4.0-ac10's agpgart drivers, but
that doesn't help either. .config is available on request.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

