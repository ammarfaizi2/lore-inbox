Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbULXPyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbULXPyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 10:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULXPyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 10:54:15 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:47627 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S261221AbULXPyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 10:54:12 -0500
Subject: Re: kernel BUG at fs/inode.c:1116 with
	2.6.10-rc{2-mm4,3-mm1}[repost]
From: Vladimir Saveliev <vs@namesys.com>
To: tabris <tabris@tabris.net>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200412241032.02190.tabris@tabris.net>
References: <200412231923.14444.tabris@tabris.net>
	 <20041224000938.22b9f909.akpm@osdl.org>
	 <200412241032.02190.tabris@tabris.net>
Content-Type: text/plain
Message-Id: <1103903639.23776.50.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 24 Dec 2004 18:54:00 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Fri, 2004-12-24 at 18:31, tabris wrote:
> On Friday 24 December 2004 3:09 am, Andrew Morton wrote:
> > tabris <tabris@tabris.net> wrote:
> > > 	Attached are the BUG reports for 2.6.10-rc2-mm4 (multiple BUG
> > > reports) and one from 2.6.10-rc3-mm1, plus dmesg from
> > > 2.6.10-rc3-mm1.
> >
> > Are you using quotas?
> 	Yes, I am using quotas.
> >
> > What filesystem types are in use?
> 	I'm using reiserFS and XFS mostly, with one ext2 partition (/boot, 
> mounted -o sync)

Would you please try to reproduce this problem with:
http://marc.theaimsgroup.com/?l=reiserfs&m=110381606727976&q=p3

