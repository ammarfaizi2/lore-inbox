Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271197AbTG2Aib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 20:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271199AbTG2Aib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 20:38:31 -0400
Received: from smtp.terra.es ([213.4.129.129]:47858 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S271197AbTG2Aia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 20:38:30 -0400
Date: Tue, 29 Jul 2003 02:38:44 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: 2.6.0-test2-mm1
Message-Id: <20030729023844.2df2fef5.diegocg@teleline.es>
In-Reply-To: <20030727233716.56fb68d2.akpm@osdl.org>
References: <20030727233716.56fb68d2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 27 Jul 2003 23:37:16 -0700 Andrew Morton <akpm@osdl.org> escribió:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm1/
> 
> - More CPU scheduler tweaks.

O10 feels great here; behaviour under heavy load (make -jbignumber) is great;
gcc doesn't starves the rest of the processes; it still allows X/xchat/xmms/etc
do some work and the system remains usable; mp3 doesn't skip too much (only
when it tries to swapin some big process like galeon but i find that normal; before
this the same load in the past starved anything not classified as "compiler").




