Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUBMDcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUBMDcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:32:21 -0500
Received: from mail.shareable.org ([81.29.64.88]:30082 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266720AbUBMDcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:32:20 -0500
Date: Fri, 13 Feb 2004 03:32:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Windl <Ulrich.Windl@RZ.Uni-Regensburg.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "filp->f_mode & 2..."
Message-ID: <20040213033218.GJ25499@mail.shareable.org>
References: <402B4FB2.mailxG23119XFU@pc5234.klinik.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402B4FB2.mailxG23119XFU@pc5234.klinik.uni-regensburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> filp->f_mode & 2 || permission(filp->f_dentry->d_inode,2,NULL)
> 
> It's obvious to some, likely for others that "2" there really stands for
> "002", the good old UNIX write permission.

That's FMODE_WRITE (= 2).  It isn't related at all to the Unix write
permission of 002, as you'll notice FMODE_READ is 1, not 4.

-- Jamie
