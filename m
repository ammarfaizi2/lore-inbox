Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVAHALv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVAHALv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVAHALT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:11:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:38289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbVAHAHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:07:53 -0500
Date: Fri, 7 Jan 2005 16:12:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hch@infradead.org, mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk,
       paulmck@us.ibm.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-Id: <20050107161225.2a09aeb5.akpm@osdl.org>
In-Reply-To: <1105136713.7079.14.camel@localhost.localdomain>
References: <1105039259.4468.9.camel@laptopd505.fenrus.org>
	<20050106201531.GJ1292@us.ibm.com>
	<20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	<20050106210408.GM1292@us.ibm.com>
	<20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	<20050106152621.395f935e.akpm@osdl.org>
	<20050106234123.GA27869@infradead.org>
	<20050106162928.650e9d71.akpm@osdl.org>
	<20050107002624.GA29006@infradead.org>
	<20050107090014.GA24946@elte.hu>
	<20050107091542.GA5295@infradead.org>
	<20050107140034.46aec534.akpm@osdl.org>
	<1105136713.7079.14.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Gwe, 2005-01-07 at 22:00, Andrew Morton wrote:
> > No, I'd say that unexports are different.  They can clearly break existing
> > code and so should only be undertaken with caution, and with lengthy notice
> > if possible.
> 
> That was done

Obviously not very well, because it didn't work.  Was a removal date given?

> > Christoph, it would be better to constraint yourself to commenting on other
> > people's actions rather than entering into premature speculation regarding
> > their motivations, especially when that speculation involves accusations of
> > corruption.
> 
> People have been trying to get this stuff fixed for a long time. There
> are no sane users of it, there are no apparent legal users of it and the
> one remaining problem has shown no sign of wishing to change and will no
> doubt try the same again in twelve months.

I doubt if that is correct.  Paul?
