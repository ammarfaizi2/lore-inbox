Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268547AbTBWVAW>; Sun, 23 Feb 2003 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbTBWVAW>; Sun, 23 Feb 2003 16:00:22 -0500
Received: from [65.244.37.61] ([65.244.37.61]:7136 "EHLO WSPNYCON1IPC.ipc.com")
	by vger.kernel.org with ESMTP id <S268547AbTBWVAW>;
	Sun, 23 Feb 2003 16:00:22 -0500
Message-ID: <170EBA504C3AD511A3FE00508BB89A9201C671F7@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.62 "unable to open initial console"
Date: Sun, 23 Feb 2003 16:11:33 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies of off-topic or screamingly idiotic or newbie :-)

Booting 2.5.62 results in no console.  Looking at syslog shows:

Warning: unable to open initial console

I am not using devfs - /dev/console is there, char major 5, minor 1.

Kernel was built without MDA or framebuffer support, without serial or
parallel console, with CONFIG_VGA_CONSOLE 1 and CONFIG_DUMMY_CONSOLE 1.

Problem has been present since at least 2.5.59.

System runs normally if booted with 2.5.24.
