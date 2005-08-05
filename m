Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVHEIEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVHEIEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVHEICL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:02:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbVHEIAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:00:55 -0400
Date: Fri, 5 Aug 2005 00:59:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, jamey@handhelds.org, anpaza@mail.ru,
       rmk@arm.linux.org.uk
Subject: Re: platform-device-driver-for-mq11xx-graphics-chip.patch added to
 -mm tree
Message-Id: <20050805005932.73721447.akpm@osdl.org>
In-Reply-To: <1123228133.7649.4.camel@localhost.localdomain>
References: <200508050719.j757J9KO032652@shell0.pdx.osdl.net>
	<1123228133.7649.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> On Fri, 2005-08-05 at 00:18 -0700, akpm@osdl.org wrote:
> > The patch titled
> > 
> >      platform-device driver for MQ11xx graphics chip
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      platform-device-driver-for-mq11xx-graphics-chip.patch
> > 
> >  drivers/platform/.tmp_versions/mq11xx_base.mod |    2 
> 
> I doubt that should be there...

Zap.

> >  drivers/platform/Kconfig                       |   23 
> >  drivers/platform/Makefile                      |    5 
> >  drivers/platform/mq11xx.h                      |  925 ++++++++++++++++
> >  drivers/platform/mq11xx_base.c                 | 1390 +++++++++++++++++++++++++
> 
> I'm also still wondering if drivers/mfd would be better in the long term
> for code like this (as mentioned in various threads on LKML). That way
> it is doesn't have to be platform device specific...

That's what Russell thinks.
