Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUJVRRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUJVRRV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUJVRNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:13:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59782 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S268435AbUJVRGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:06:16 -0400
Date: Fri, 22 Oct 2004 19:06:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: [PATCH] Quota warnings somewhat broken
In-Reply-To: <1098455105.19459.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0410221905030.13575@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr> 
 <20041022093423.GC31932@atrey.karlin.mff.cuni.cz> 
 <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org>
 <1098455105.19459.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Why does this code use tty_write_message() in the first place? It's a bit
>> rude to mess up the users tty without any way to disable it, isn't it?

See http://linux01.org:2222/f/hxtools/kernel/265-quota_warnflag.diff for a
patch that allows the administrator of the local box to change this behavior
via sysctl.

>Tradition I guess. It's what every other quota system does, including
>making annoying messes. In the new world order I guess it should be a
>netlink message out to dbus and the desktop ;)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
Tel 0162.3520895 or 05502.3009.63
