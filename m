Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUJOVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUJOVOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUJOVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:14:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:19092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268440AbUJOVOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:14:44 -0400
Date: Fri, 15 Oct 2004 14:12:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       becker@scyld.com
Subject: Re: [patch 2.6.9-rc3] 3c59x: reload EEPROM values at rmmod for
 needy cards
Message-Id: <20041015141250.3920ab2f.akpm@osdl.org>
In-Reply-To: <4170260D.9010905@pobox.com>
References: <20040928145455.C12480@tuxdriver.com>
	<Pine.LNX.4.44.0409291253510.1746-100000@training.scyld.com>
	<20040930091407.A10417@tuxdriver.com>
	<20041007134601.B29517@tuxdriver.com>
	<20041008123955.E14378@tuxdriver.com>
	<4170260D.9010905@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> John W. Linville wrote:
>  > Enable reload of EEPROM values in reset at rmmod for cards that need
>  > it, similar to old EEPROM_NORESET flag but in reverse.
>  > 
>  > Signed-of-by: John W. Linville <linville@tuxdriver.com>
> 
>  Andrew... ack/nak?

I queued it up.

>  Seems OK to me, provided that it chills out in -mm for a while for 
>  people to test.

Yes, it takes some time for problems in this area to be shaken out.
