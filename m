Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTDJNis (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 09:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTDJNis (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 09:38:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:64190 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264042AbTDJNir (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 09:38:47 -0400
Date: Thu, 10 Apr 2003 15:50:22 +0200
From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: unusual_devs entries for Vivicam and others
Message-Id: <20030410155022.0bd6ccd0.hanno@gmx.de>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While searching for hints how to get the Vivicam 355 working in Linux, I
found that Lycoris Desktop/LX supports it.

I looked into their sources and they have a patch for adding
unusual_devs-Entries to the kernel-source.

I also found that they have two patches for sony-cameras not in the
kernel.

I testet the Vivicam-Patch and it works. I didn't test the
Sony-patches, so I don't know about them. (I assume they work, ask
lycoris for details)

Please apply the Vivicam-Patch to the kernel. I've put the patches
online, because to get them from lycoris, you have to download their
source-iso-cd.
http://cvs.gentoo.org/~hanno/linux-vivicam-unusual-dev.patch

The Sony-patches are at:
http://cvs.gentoo.org/~hanno/linux-sony-dsc-f707-unusual-dev.patch
http://cvs.gentoo.org/~hanno/linux-sony-clie-n760c-unusual-dev.patch
