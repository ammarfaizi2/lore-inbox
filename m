Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVHEHuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVHEHuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVHEHuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:50:03 -0400
Received: from tim.rpsys.net ([194.106.48.114]:20409 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262894AbVHEHuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:50:00 -0400
Subject: Re: platform-device-driver-for-mq11xx-graphics-chip.patch added to
	-mm tree
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: jamey@handhelds.org, anpaza@mail.ru, rmk@arm.linux.org.uk
In-Reply-To: <200508050719.j757J9KO032652@shell0.pdx.osdl.net>
References: <200508050719.j757J9KO032652@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 08:48:53 +0100
Message-Id: <1123228133.7649.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 00:18 -0700, akpm@osdl.org wrote:
> The patch titled
> 
>      platform-device driver for MQ11xx graphics chip
> 
> has been added to the -mm tree.  Its filename is
> 
>      platform-device-driver-for-mq11xx-graphics-chip.patch
> 
>  drivers/platform/.tmp_versions/mq11xx_base.mod |    2 

I doubt that should be there...

>  drivers/platform/Kconfig                       |   23 
>  drivers/platform/Makefile                      |    5 
>  drivers/platform/mq11xx.h                      |  925 ++++++++++++++++
>  drivers/platform/mq11xx_base.c                 | 1390 +++++++++++++++++++++++++

I'm also still wondering if drivers/mfd would be better in the long term
for code like this (as mentioned in various threads on LKML). That way
it is doesn't have to be platform device specific...

Richard

