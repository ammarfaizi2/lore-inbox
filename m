Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVL3LCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVL3LCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 06:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVL3LCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 06:02:46 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:39186 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751244AbVL3LCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 06:02:45 -0500
Date: Fri, 30 Dec 2005 12:06:07 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20051230120607.47951ec6.khali@linux-fr.org>
In-Reply-To: <1135936882.7465.18.camel@localhost>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	<200512292100.27536.zippel@linux-m68k.org>
	<20051229211350.4115b799.khali@linux-fr.org>
	<200512292119.10139.zippel@linux-m68k.org>
	<20051229220730.1c22b1a4.khali@linux-fr.org>
	<1135936882.7465.18.camel@localhost>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> > > On Thursday 29 December 2005 21:13, Jean Delvare wrote:
> > > 
> > > > No, it wouldn't produce the desired effect anymore.
> > > 
> > > Did you try it?
>
> 	Using choice with two tristate config options seems to provide the
> better look and feel, while keeping the desired effect. The only
> drawback is that Kconfig doesn't accept default values for the "config"
> inside a choice. It would be nice if both choice and the ALSA/OSS
> options be marked as "m" by default.
> 	Anyway, IMHO, this is better and clearer than the previous patches.

Can you please rebase it on Linus' latest (2.6.15-rc7-git4)? So that I
can give it a try...

Thanks,
-- 
Jean Delvare
