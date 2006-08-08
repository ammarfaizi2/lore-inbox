Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWHHRk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWHHRk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWHHRk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:40:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965010AbWHHRk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:40:57 -0400
Date: Tue, 8 Aug 2006 10:37:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@stusta.de>,
       Jeff Dike <jdike@addtoit.com>, "lkml@o2.pl / IMAP" <lkml@o2.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm1: O= builds broken
Message-Id: <20060808103730.47b7e3b4.akpm@osdl.org>
In-Reply-To: <1155054823.19249.66.camel@localhost.localdomain>
References: <20060806002400.694948a1.akpm@osdl.org>
	<20060806082321.GZ25692@stusta.de>
	<20060807195912.GA14126@mars.ravnborg.org>
	<1155054823.19249.66.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2006 09:33:43 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> Andrew, if another -mm isn't imminent, could this patch make into into
> the hot-fixes directory for -mm1 and/or -mm2?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/kbuild-create-output-directory-for-hostprogs-with-o=-build.patch

> BTW, I'm also seeing these in my build now:
> 
> 	scripts/Makefile.host:88: host-objdirs=
> 
> It doesn't appear to hurt anything, but it is a bit weird looking.

metoo.  Sam has fixed that now.
