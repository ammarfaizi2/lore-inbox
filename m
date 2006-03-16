Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWCPXXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWCPXXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWCPXXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:23:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4283 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964893AbWCPXXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:23:31 -0500
Subject: Re: Invalidating page of a user level process from a device driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: osuv osuv <osuvthebest@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060316160337.12684.qmail@web8406.mail.in.yahoo.com>
References: <20060316160337.12684.qmail@web8406.mail.in.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2006 23:29:53 +0000
Message-Id: <1142551794.23236.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-16 at 16:03 +0000, osuv osuv wrote:
>    I need to invalidate a user process page . To
> invalidate the page , i need to get into kernel space
> , so i am using
>    the ioctl func of a char device driver. I am not
> getting the right functions or the right way to
> invalidate a page.


What is wrong with using munmap() ?

