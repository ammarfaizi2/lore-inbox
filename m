Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271311AbTHCVvS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTHCVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:51:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:40874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271295AbTHCVu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:50:58 -0400
Date: Sun, 3 Aug 2003 14:52:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Diffie <diffie@blazebox.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-Id: <20030803145211.29eb5e7c.akpm@osdl.org>
In-Reply-To: <20030803214755.GA1010@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net>
	<20030801144455.450d8e52.akpm@osdl.org>
	<20030803015510.GB4696@blazebox.homeip.net>
	<20030802190737.3c41d4d8.akpm@osdl.org>
	<20030803214755.GA1010@blazebox.homeip.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diffie <diffie@blazebox.homeip.net> wrote:
>
> I think this bug is due to me using the aic7xxx_old code ver 5.x.x.
> 
>  Under kernel 2.4.21 the aic7xxx (new) is ver 6.2.8 and it works great
>  with Adaptec AHA-2940U2W controller i have.
> 
>  On 2.6.0-test2-mm3 (tried Linus test1,test2,mm1 and mm2) the NEW aic7xxx
>  uses ver 6.2.35 and will not scan my IBM drive even though it
>  initializes the correct SCSI ID,LUN etc...
> 
>  I would like to contact and report this issue to the aic7xxx maintaner
>  and perhaps get it resolved.Where would be the best place to report this
>  kind of problem?
> 
>  I have taken few screen captures which are available at:
>  http://www.blazebox.homeip.net:81/diffie/images/2.6.0-test2/ and show
>  the aic7xxx (new) failure.

An appropriate way to report this would be to email Justin (CC'ed here)
and linux-scsi@vger.kernel.org.

