Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbTDAOmn>; Tue, 1 Apr 2003 09:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTDAOmn>; Tue, 1 Apr 2003 09:42:43 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:60312 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262561AbTDAOmm>;
	Tue, 1 Apr 2003 09:42:42 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16009.43013.754047.36875@gargle.gargle.HOWL>
Date: Tue, 1 Apr 2003 16:53:57 +0200
dFrom: mikpe@csd.uu.se
To: LKML <linux-kernel@vger.kernel.org>
Cc: simon@mtds.com
Subject: New: SSE2 enabled by default on Celeron (P4 based) 
In-Reply-To: <17080000.1049207466@[10.10.2.4]>
References: <17080000.1049207466@[10.10.2.4]>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh writes:
 > http://bugme.osdl.org/show_bug.cgi?id=527
 > 
 >            Summary: SSE2 enabled by default on Celeron (P4 based)
 >     Kernel Version: 2.5.64
 >             Status: NEW
 >           Severity: normal
 >              Owner: mbligh@aracnet.com
 >          Submitter: simon@mtds.com
 > 
 > 
 > Distribution: Customised RH 7.1 with many mods
 > Hardware Environment: Celeron i686 (P4 based)
 > Software Environment: gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
 > 
 > Problem Description: Kernel compiles OK, but at boot kernel panics as CPU
 > doesn't support SSE2
 > 
 > Steps to reproduce: Compile kernel choosing *any* Celeron option
 > 
 > /proc/cpuinfo:-
 > processor       : 0
 > vendor_id       : GenuineIntel
 > cpu family      : 6
 > model           : 11

This is NOT a P4-based Celeron. It's a P6 Tualatin Celeron, and as such,
it does not support SSE2.

This CPU needs a kernel configured for a Pentium III or less.
