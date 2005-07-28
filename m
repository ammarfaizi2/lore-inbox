Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVG1UT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVG1UT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVG1URS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:17:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261838AbVG1UQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:16:31 -0400
Date: Thu, 28 Jul 2005 13:15:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050728131525.31fa8640.akpm@osdl.org>
In-Reply-To: <42E957B5.8040606@gmail.com>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<42E957B5.8040606@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke <iogl64nx@gmail.com> wrote:
>
> Hello Andrew,
> 
> I have some questions :-)
> Reiser4:
> 
> why there are undefined functions implemented that currently not in use?
> This messages appeared first time in 2.6.13-rc3-mm2.
> 
> Any why it complains even CONFIG_REISER4_DEBUG is not set?

That's due to the code using `#if CONFIG_xx' instead of `#ifdef'.

> 
> SCSI:
> 
> CONFIG_SCSI_QLA2XXX=y ? I haven't choose that one..I never did..and 
> where is the config located?

Someone was doing wrong things in the Makefile.  I think that has been
subsequently fixed.

