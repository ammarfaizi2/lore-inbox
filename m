Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSGGXSv>; Sun, 7 Jul 2002 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSGGXSu>; Sun, 7 Jul 2002 19:18:50 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:19586 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316632AbSGGXSt> convert rfc822-to-8bit; Sun, 7 Jul 2002 19:18:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Dave Hansen <haveblue@us.ibm.com>,
       Thunder from the hill <thunder@ngforever.de>
Subject: Re: BKL removal
Date: Mon, 8 Jul 2002 01:23:00 +0200
User-Agent: KMail/1.4.1
Cc: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm> <3D28C3F0.7010506@us.ibm.com>
In-Reply-To: <3D28C3F0.7010506@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207080123.00487.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BKL use isn't right or wrong -- it isn't a case of creating a deadlock
> or a race.  I'm picking a relatively random function from "grep -r
> lock_kernel * | grep /usb/".  I'll show what I think isn't optimal
> about it.

Perhaps, we could agree that the BKL is used wrongly if it
won't fulfill its presumed function, or fulfills another function
than the obvious without a comment stating that, or fulfills
a non obvious function without any comment ?

The first case is IMHO the worst, because, although BKL
can't hurt technically, it obscures locking.

	Regards
		Oliver

