Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTBFVXh>; Thu, 6 Feb 2003 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbTBFVXh>; Thu, 6 Feb 2003 16:23:37 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:59776 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267396AbTBFVXg>; Thu, 6 Feb 2003 16:23:36 -0500
Date: Thu, 6 Feb 2003 15:33:19 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
In-Reply-To: <20030206132346.4b635676.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302061529240.998-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Andrew Morton wrote:

> Thomas Molina <tmolina@cox.net> wrote:
> >
> > > Everything you describe is consistent with a kernel which does not have ext3
> > > compiled into it.
> > ...
> > I'm aware of that.
> 
> In that case you may be experiencing the mysterious vanishing
> ext3_read_super-doesn't-work bug.  Usually a recompile/relink makes it go
> away.  I haven't seen it in months.
> 
> Could you please drop this additional debugging in there and see
> what happens?

I'll try it, but a question did occur to me.  I got the hang while booting 
a freshly-compiled 2.5.59, but the error message was received after 
supposedly cleaning and recovering the journal.  That was using the stock 
RedHat 8.0 kernel, 2.4.18-24.8.0, which most certainly does have ext3 
support.  Would the bug you described affect a following boot into a 
totally different kernel?

