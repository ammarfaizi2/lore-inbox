Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUBYBu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUBYBuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:50:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:32198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262368AbUBYBrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:47:19 -0500
Date: Tue, 24 Feb 2004 17:48:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
Message-Id: <20040224174845.128f03f9.akpm@osdl.org>
In-Reply-To: <1077672147.2857.78.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<1077668801.2857.63.camel@cog.beaverton.ibm.com>
	<20040224170645.392abcff.akpm@osdl.org>
	<1077672147.2857.78.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> > Could you try reverting aic7xxx-deadlock-fix.patch?  Also, add
> > initcall_debug to the boot command just so we know we aren't blaming the
> > wrong thing.
> 
> I was suspecting that patch, unfortunately reverting it doesn't seem to
> help.

Bah.  No sysrq-t output?

If you could send me the .config I'll see if I can make it happen on test
box #47.

