Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVFIPwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVFIPwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVFIPwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:52:43 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:6668 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262021AbVFIPwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:52:35 -0400
Date: Thu, 9 Jun 2005 17:52:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-Id: <20050609175236.6e042482.khali@linux-fr.org>
In-Reply-To: <20050609081035.GA23783@kroah.com>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
	<20050607204733.1a48e5dc.khali@linux-fr.org>
	<20050609081035.GA23783@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

> > This one triggers a compilation warning. Proposed fix:
> 
> What warning?  I don't see anything here...

drivers/usb/media/pwc/pwc-uncompress.c: In function `pwc_decompress':
drivers/usb/media/pwc/pwc-uncompress.c:140: warning: unreachable code at beginning of switch statement

This is gcc 3.3.4. Strange that you don't have it.

Thanks,
-- 
Jean Delvare
