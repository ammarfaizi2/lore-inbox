Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUA3V7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUA3V7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:59:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:55447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264313AbUA3V7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:59:11 -0500
Date: Fri, 30 Jan 2004 14:00:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-Id: <20040130140024.4b409335.akpm@osdl.org>
In-Reply-To: <20040130211256.GZ9155@sun.com>
References: <20040130014108.09c964fd.akpm@osdl.org>
	<1075489136.5995.30.camel@moria.arnor.net>
	<200401302007.26333.thomas.schlichter@web.de>
	<1075490624.4272.7.camel@laptop.fenrus.com>
	<20040130114701.18aec4e8.akpm@osdl.org>
	<20040130201731.GY9155@sun.com>
	<20040130123301.70009427.akpm@osdl.org>
	<20040130211256.GZ9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> In fact, here is a rough cut (would need a coupel exported syms, too).  The
> lack of any way to handle errors bothers me.  printk and fail?  yeesh.

Seems to be a good way to go.  It doesn't seem likely that any other parts
of the kernel will want to be setting the group ownership in this way.

