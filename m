Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVAGSAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVAGSAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVAGR7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:59:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22443 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261366AbVAGR52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:57:28 -0500
Message-ID: <41DECD7A.5030600@pobox.com>
Date: Fri, 07 Jan 2005 12:57:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Clements <clem@clem.clem-digital.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-bk10 fails compile -- kernel/sys.c
References: <200501071543.j07FhrPt007757@clem.clem-digital.net>
In-Reply-To: <200501071543.j07FhrPt007757@clem.clem-digital.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements wrote:
> fyi:
> 
> kernel/sys.c: In function `sys_setsid':
> kernel/sys.c:1078: `tty_sem' undeclared (first use in this function)
> kernel/sys.c:1078: (Each undeclared identifier is reported only once
> kernel/sys.c:1078: for each function it appears in.)
> make[1]: *** [kernel/sys.o] Error 1

include linux/tty.h to fix.

	Jeff



