Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTGFMii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 08:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTGFMii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 08:38:38 -0400
Received: from lns-th2-4f-81-56-217-5.adsl.proxad.net ([81.56.217.5]:61057
	"EHLO www.certral.com") by vger.kernel.org with ESMTP
	id S262202AbTGFMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 08:38:37 -0400
Date: Sun, 6 Jul 2003 14:54:18 +0200
From: FD Cami <francois.cami@free.fr>
To: Marcelo Tosatti <marcelo@freak.distro.conectiva>
Cc: linux-kernel@vger.kernel.org
Subject: [linux-kernel][BUG since 2.4.21] PCM sound volume not working
Message-Id: <20030706145418.03834818.francois.cami@free.fr>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm currently running 2.4.22pre3 and noticed adjusting
the sound volume using XMMS didn't work anymore (but using
gnome-1.4's sound-applet works, it controls the Master volume).

Booting back into 2.4.21, I realized it didn't work either...
Booting back into 2.4.21rc7 solved the problem.

XMMS is set to use OSS (not ESD), and volume controls PCM, not
Master.

I'm currently not subscribed to linux-kernel@vger.kernel.org due to
a mail server problem, please CC me.

FD Cami
 
