Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUBZIOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbUBZIOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:14:18 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:54236 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262736AbUBZIOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:14:16 -0500
Subject: Re: filesystem logical block number
From: Vladimir Saveliev <vs@namesys.com>
To: Yijian Wang <yiwang@ECE.NEU.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.58.0402251709150.16469@benson>
References: <Pine.GSO.4.58.0402251709150.16469@benson>
Content-Type: text/plain
Message-Id: <1077783254.3256.75.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 26 Feb 2004 11:14:14 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2004-02-26 at 01:11, Yijian Wang wrote:
> Hello,
> 
> Does anybody know how to get the logical block numbers of file accesses?
> i.e. if I want to read some data from a file, how can I know which block
> numbers I am accessing? Is there any system call?
> 
#include <linux/fs.h>

ioctl (fd, FIBMAP, &block)

You have to run this as root, though

> Thank you!
> 
> regards,
> Yijian Wang
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

