Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWCYTS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWCYTS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWCYTS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:18:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37510 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932254AbWCYTS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:18:59 -0500
Date: Sat, 25 Mar 2006 20:18:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Edward Chernenko <edwardspec@yahoo.com>
cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
In-Reply-To: <20060324162107.50804.qmail@web37710.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61.0603252016510.29793@yvahk01.tjqt.qr>
References: <20060324162107.50804.qmail@web37710.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch adds ident daemon to net/gnuidentd/
>directory.
>Apply to: 2.6.15.1.
>Patch is here:
>http://unwd.sourceforge.net/gnuidentd-2.6.15.patch
>
>I used two threads: one for connections handling and
>another for tracking /etc/passwd changes through
>inotify.
>Additionally, root can set users hiding rules using
>file in /proc. 
>
>I'm awaiting your notes/tips.


I dislike this concept. khttpd once tried the same (moving 
userspace to kernelspace) -- and it's out again.




Jan Engelhardt
-- 
