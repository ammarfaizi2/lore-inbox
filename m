Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTKXU7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTKXU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:59:47 -0500
Received: from wormhole.wms-hn.de ([141.7.87.2]:8107 "EHLO wormhole.wms-hn.de")
	by vger.kernel.org with ESMTP id S261680AbTKXU7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:59:45 -0500
Subject: Can't login with kernel 2.6
From: Tilo Lutz <TiloLutz@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069711178.2331.8.camel@tilo.rz.uni-karlsruhe.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 24 Nov 2003 22:59:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm running Suse 9.0.
I'V upgraded to module-init-tools 0.9.15pre4
nd util-linux to 2.12pre.
The system runs without any probems with
kernel 2.4.21 but doesn't with kernel 2.6.0-test10

I can't login as any user in normal runlevels.

A script to set up network has shown an error:
chown root:root user unknown.
I also get en error: /dev/tty unknown device.

If I start in runlevel S i can log in as root
which doesn't work in any other runlevel.

I don't know where to look for the problem. I haven't
found an answer in Google or maillinglist archive.
All user accounts are stored in /etc/passwd / /etc/shadow.
Passwords are only encrypted with crypt().
I use PAM to authenticate.

With krenel 2.6.0-test9 I also got a very strange error when
some programs are started in init:
Invalid ELF header.

Any ides how to solve this?

Thank you for your help

Tilo


