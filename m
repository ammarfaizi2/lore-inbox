Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWFQFou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWFQFou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFQFou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:44:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30483 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751097AbWFQFot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:44:49 -0400
Date: Sat, 17 Jun 2006 05:16:58 +0000
From: Pavel Machek <pavel@ucw.cz>
To: carl <cspalletta@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/1] vfs: support for COW files in sys_open
Message-ID: <20060617051657.GA7464@ucw.cz>
References: <20060609165321.66EEC118601@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609165321.66EEC118601@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Giving the O_COW flag to open() will return a special error, if
> IS_COW(inode) and write permissions are expressed or implied.  COW-aware
> applications may set this flag and deal with this error according to
> some user defined policy.  This will not change the semantics of any
> existing application or affect any kernel user of open_namei(); nor does
> it affect future applications unless they use O_COW.  Filesystem level
> code is unimplemented except for an ext2 example.

Can you give us overview how this is used? COW for ext2 seems nice...
Is the plan to allow cp -a --cow linux linux.new ?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
