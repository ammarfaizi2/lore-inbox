Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUCOP2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbUCOP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 10:28:48 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:7945 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262602AbUCOP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 10:28:44 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Date: Mon, 15 Mar 2004 14:25:15 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org>
In-Reply-To: <20040314201457.23fdb96e.akpm@osdl.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403151425.15483@WOLK>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 March 2004 05:14, Andrew Morton wrote:

Hi Herbert, Andrew,

> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >  ; this patch adds some functionality to the --bind
> >  ; type of vfs mounts.

> This won't apply any more.  We very recently changed a large number of
> filesystems to not call update_atime() from within their readdir functions.
> That operation was hoisted up to vfs_readdir().

right. Anyway, I like to see this merged into -mm for wider testing after 
Herbert has fixed up some things like update_atime removal etc.

I personally use it for a long time now and I really like it.

ciao, Marc

