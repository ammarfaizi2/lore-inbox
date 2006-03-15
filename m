Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWCODed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWCODed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWCODed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:34:33 -0500
Received: from xenotime.net ([66.160.160.81]:721 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964798AbWCODed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:34:33 -0500
Date: Tue, 14 Mar 2006 19:36:29 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: Module Ref Counting & ibmphp
Message-Id: <20060314193629.7deccc83.rdunlap@xenotime.net>
In-Reply-To: <20060315032549.83543.qmail@web52605.mail.yahoo.com>
References: <20060315000212.GB6533@kroah.com>
	<20060315032549.83543.qmail@web52605.mail.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006 14:25:49 +1100 (EST) Srihari Vijayaraghavan wrote:

> --- Greg KH <greg@kroah.com> wrote:
> > [...] 
> > No.  I don't think this driver likes to be unloaded
> > due to the
> > instability of the hardware if that happens.  So
> > let's just let it not
> > be unloaded, and hope that the hardware can die in
> > peace and never get
> > put into any new machines...
> 
> Fair enough & thanks for the explanation.
> 
> I've quickly tested Stephen's patch, which does the
> trick (no more 4.3 billion usages :)).

That was ~0 (0xffffffff, -1) for those who missed it.

> Note to Stephen: Pls don't remove people in the cc
> list. I almost missed your patch & hence my testing of
> it.


---
~Randy
