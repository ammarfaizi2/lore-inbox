Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262592AbTCIUHp>; Sun, 9 Mar 2003 15:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCIUHp>; Sun, 9 Mar 2003 15:07:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29837 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S262592AbTCIUHo>;
	Sun, 9 Mar 2003 15:07:44 -0500
Date: Sun, 9 Mar 2003 15:19:02 -0500 (EST)
From: davidsen <root@tmr.com>
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Module XXX can not be unloaded
Message-ID: <Pine.LNX.4.44.0303091500250.4012-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My logs are filled with this message, in spite of:
 1 - nothing is trying to unload these modules
 2 - my kernels are built w/o module unloading because I have never yet 
     found any module which *could* be unloaded by the new code.

I presume this should be replaced by a message saying that module 
unloading is not configured, and that it should only happen when a program 
tries to unload a module, rather than generating many lines of meaningless 
log babble.

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


