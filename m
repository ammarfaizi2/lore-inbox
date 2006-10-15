Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWJOPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWJOPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWJOPnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 11:43:09 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:52358 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751003AbWJOPnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 11:43:07 -0400
Date: Sun, 15 Oct 2006 17:39:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikita Danilov <nikita@clusterfs.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] use %p for pointers
In-Reply-To: <17710.8478.278820.595718@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.61.0610151737420.7672@yvahk01.tjqt.qr>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk>
 <452D3BB6.8040200@zytor.com> <17710.8478.278820.595718@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>so %p already has to output '0x', it's lib/vsprintf.c to blame for
>non-conforming behavior. What about
>
>Signed-off-by: Nikita Danilov <danilov@gmail.com>
>
>Index: git-linux/lib/vsprintf.c

Seems like the mail I wrote did not arrive. In that case, I'll give you 
an URL: http://jengelh.hopto.org/f/nikita-printf-p.diff.bz2 (compile 
tested)
Signed-off-by: Jan Engelhardt <jengelh@gmx.de>


	-`J'
-- 
