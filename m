Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUI0FWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUI0FWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUI0FWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 01:22:23 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:22323 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266003AbUI0FWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 01:22:21 -0400
Date: Mon, 27 Sep 2004 09:22:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make make install install modules too
Message-ID: <20040927072246.GA8613@mars.ravnborg.org>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 06:00:51PM +0100, Matthew Wilcox wrote:
> 
> I keep forgetting to run 'make modules_install' after make install.  Since
> make now compiles modules too and there's no separate make modules step,
> it seems to make sense that make install should also install modules.

No, we do not want to change such basic behaviour.
So many poeple are used to current scheme with:
make modules_install && make install

that it would't be worth breaking their ways of working.

	Sam
