Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbSJHMaC>; Tue, 8 Oct 2002 08:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbSJHMaC>; Tue, 8 Oct 2002 08:30:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:8463 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262174AbSJHMaB>; Tue, 8 Oct 2002 08:30:01 -0400
Message-ID: <3DA2D130.962EA165@aitel.hist.no>
Date: Tue, 08 Oct 2002 14:36:00 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 Vesa framebuffer hang on fontchange without 8x16 font
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried running the vesa framebuffer with the 4x6 font only,
for fun.  It booted and was hard to look at as expected,
but hung as soon as the boot scripts tried to change font.

I tried again with 4x6 _and_ 8x8, that hung at the same place.
finally, removing 4x6, 8x8 and enabling 8x16-font allowed
a normal boot.

This is using the debian unstable distribution,
2.5.41 UP, preempt, some debugging options,
and a
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)

Helge Hafting
