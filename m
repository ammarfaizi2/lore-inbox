Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267090AbUBMUqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267142AbUBMUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:46:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:16591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267090AbUBMUqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:46:10 -0500
Date: Fri, 13 Feb 2004 12:45:55 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Tommi Virtanen <tv@tv.debian.net>, Leann Ogasawara <ogasawara@osdl.org>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't allow / in class device names
Message-Id: <20040213124555.00cbf3d7@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040213203448.GB14048@kroah.com>
References: <20040213102755.27cf4fcd.shemminger@osdl.org>
	<20040213203448.GB14048@kroah.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the "fix" is to just not do this in the driver.  I'm not going to
> apply this patch, sorry.
> 
> thanks,
> 
> greg k-h

Bah, kernel API's should check there arguments.  One of my peeve's about sysfs is
that it is far too lazy about checking it's inputs.  Especially, when the restrictions
are not well documented, the code needs to validate.

