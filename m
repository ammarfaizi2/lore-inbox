Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWE1IWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWE1IWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 04:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWE1IWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 04:22:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:6621 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751279AbWE1IWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 04:22:38 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
From: Mike Galbraith <efault@gmx.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <1148803384.8757.7.camel@homer>
References: <1148793123.7572.22.camel@homer>
	 <20060528052514.GQ27946@ftp.linux.org.uk> <1148796018.11873.11.camel@homer>
	 <1148802491.8083.7.camel@homer>  <1148803384.8757.7.camel@homer>
Content-Type: text/plain
Date: Sun, 28 May 2006 10:24:35 +0200
Message-Id: <1148804675.7755.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 10:03 +0200, Mike Galbraith wrote:

> Yup, mm3 makes reliable kaboom.
> 
> I suppose the first thing to do is see if it's cfq, and then maybe toss
> a dart at the patch list.

That was too easy.  It's git-cfq.patch.

	-Mike

