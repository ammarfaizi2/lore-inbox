Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271357AbUJVP2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271357AbUJVP2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271331AbUJVP2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:28:38 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58335 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271357AbUJVP2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:28:33 -0400
Subject: Re: [PATCH] Quota warnings somewhat broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr>
	 <20041022093423.GC31932@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098455105.19459.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 15:25:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 16:07, Linus Torvalds wrote:
> Why does this code use tty_write_message() in the first place? It's a bit 
> rude to mess up the users tty without any way to disable it, isn't it? 

Tradition I guess. It's what every other quota system does, including
making annoying messes. In the new world order I guess it should be a
netlink message out to dbus and the desktop ;)

