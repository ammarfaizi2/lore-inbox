Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUATBrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbUATBrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:47:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:19412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265326AbUATBnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:43:33 -0500
Date: Mon, 19 Jan 2004 17:17:34 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
       Brian King <brking@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       kai@germaschewski.name, sam@ravnborg.org, akpm@osdl.org
Subject: Re: Question on MODULE_VERSION macro
Message-ID: <20040120011734.GB6309@kroah.com>
References: <20040119214233.GF967@beaverton.ibm.com> <20040120005915.2A54A17DD8@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120005915.2A54A17DD8@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 11:57:38AM +1100, Rusty Russell wrote:
> In message <20040119214233.GF967@beaverton.ibm.com> you write:
> > Rusty,
> > 	Christoph mentioned that a MODULE_VERSION macro may be pending.
> 
> Hey, thanks Christoph for the reminder.  I stopped when we were
> frozen.
> 
> This still seems to apply.  Do people think this is huge overkill, or
> a work of obvious beauty and genius?

Looks sane.  I'm guessing that modinfo can show this?

> Doesn't put things in sysfs, but Greg was working on that for module
> parameters... Greg?

Oh yeah, I'll dig out that patch later this week.  An older version has
been sitting in my bk tree forever, need to update it with the last
changes you sent me.

thanks,

greg k-h
