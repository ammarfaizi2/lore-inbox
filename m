Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUAMAzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUAMAzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:55:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:49327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263125AbUAMAzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:55:39 -0500
Date: Mon, 12 Jan 2004 16:52:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andreas Beckmann <sparclinux@abeckmann.de>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] spelling: "Unix 98" -> "Unix98"
Message-Id: <20040112165231.2384aa6e.rddunlap@osdl.org>
In-Reply-To: <3FD277E5.5000306@abeckmann.de>
References: <3FD277E5.5000306@abeckmann.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Dec 2003 01:44:21 +0100 Andreas Beckmann <sparclinux@abeckmann.de> wrote:

| "Unix98" is spelled as "Unix 98" at three locations: the config.in files 
| for the architectures sparc64, sh and sh64.
| My patch changes these to be "Unix98" like everywhere else.
| The defconfig files for these architectures could be regenerated to 
| match these changes.

Hi,

I guess that this patch might as well be merged, for the sake of
consistency with the other uses of "Unix98" in config.in files.
[The patch applies with 1-2 lines of offsets due to the addtion
of the OOM_KILLER option.]

However, looking at www.opensource.org, the
"UNIX 98" branding seems to be spelled "UNIX 98".

--
~Randy



--- linux-2.4.23/arch/sparc64/config.in.orig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.23/arch/sparc64/config.in	2003-12-05 21:49:04.000000000 +0100
@@ -247,7 +247,7 @@
 
 # This one must be before the filesystem configs. -DaveM
 mainmenu_option next_comment
-comment 'Unix 98 PTY support'
+comment 'Unix98 PTY support'
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
--- linux-2.4.23/arch/sh64/config.in.orig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.23/arch/sh64/config.in	2003-12-05 21:48:52.000000000 +0100
@@ -231,7 +231,7 @@
 fi
 
 
-comment 'Unix 98 PTY support'
+comment 'Unix98 PTY support'
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
--- linux-2.4.23/arch/sh/config.in.orig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.23/arch/sh/config.in	2003-12-05 21:48:42.000000000 +0100
@@ -369,7 +369,7 @@
 if [ "$CONFIG_SERIAL" = "y" -o "$CONFIG_SH_SCI" = "y" ]; then
    bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
 fi
-comment 'Unix 98 PTY support'
+comment 'Unix98 PTY support'
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256

