Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRCWWVQ>; Fri, 23 Mar 2001 17:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCWWVH>; Fri, 23 Mar 2001 17:21:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4369 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131482AbRCWWUz>; Fri, 23 Mar 2001 17:20:55 -0500
Subject: Re: Problems with latest changes in kernel and X
To: german@piraos.com (German Gomez Garcia)
Date: Fri, 23 Mar 2001 22:21:58 +0000 (GMT)
Cc: dri-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org (Mailing List Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0103232104590.306-100000@hal9000.piraos.com> from "German Gomez Garcia" at Mar 23, 2001 09:10:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gZwY-0005Yf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	After upgrading to latest 2.4.2-ac23 (that includes latest changes
> from 2.4.3-pre6) X doesn't start anymore. It was working perfectly for
> 2.4.2-ac20. I'm using DRI CVS, but it seems to have little to do with DRI
> as disabling completely DRI doesn't help. 

DRI will not work with ac23 or 3pre6. The mm locking changed to avoid a deadlock
problem versus procfs and stuff.

