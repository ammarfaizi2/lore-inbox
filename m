Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUEKVly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUEKVly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUEKVly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:41:54 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:7665 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264129AbUEKVlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:41:51 -0400
Date: Tue, 11 May 2004 14:41:48 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Larsson <alexl@redhat.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Nautilus <nautilus-list@gnome.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040511214148.GA7299@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex> <20040511024701.GA19489@taniwha.stupidest.org> <1084287762.19104.135.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084287762.19104.135.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:02:42PM +0200, Alexander Larsson wrote:

> Its the single thing which forces users of dnotify to have an
> otherwise useless daemon.

fam?  fam is useless for reasons other than dnotify.

> Signals are process global resources. As such, a library can't
> allocate them, so dnotify can't be used in a library.

That's simply bogus.  Pass in the signal number to the library if
necessary.  inotify sounds more like a hack to keep some gnome crap
happy than anything else.



  --cw
