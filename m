Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbULFRwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbULFRwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULFRwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:52:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:59276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbULFRvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:51:47 -0500
Date: Mon, 6 Dec 2004 09:51:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Gang Xu <roaming_pig@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RSA in kernel
Message-ID: <20041206095145.P14339@build.pdx.osdl.net>
References: <20041206165810.43823.qmail@web54705.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041206165810.43823.qmail@web54705.mail.yahoo.com>; from roaming_pig@yahoo.com on Mon, Dec 06, 2004 at 08:58:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gang Xu (roaming_pig@yahoo.com) wrote:
> Hi,
> 
> I am interested in using RSA functions in kernel. I
> searched RSA in the archive and read all threads. It
> seems that some developers (Tom, Joy, Serge and more?)
> were planning to start porting RSA to kernel in June.
> Is there a module available now? 

It's been done a few times, but nothing is in mainline.  You'll find
it buried in digsig[1], but it's not a standalone module, and I believe
there's still cryptoapi work needed to support assymetric crypto.

[1] http://disec.sourceforge.net/

thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
