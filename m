Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUGUWsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUGUWsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUGUWsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:48:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:8909 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266764AbUGUWso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:48:44 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] delete devfs
Date: Thu, 22 Jul 2004 00:47:53 +0200
User-Agent: KMail/1.6.2
Cc: Jesse Stockall <stockall@magma.ca>, linux-kernel@vger.kernel.org
References: <20040721141524.GA12564@kroah.com> <1090446817.8033.18.camel@homer.blizzard.org> <20040721220529.GB18721@kroah.com>
In-Reply-To: <20040721220529.GB18721@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407220047.53153.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 22. Juli 2004 00:05 schrieb Greg KH:
> > That's the point that Oliver and I raised, the "leave it till 2.7" (not
> > breaking things for real world users) argument seems stronger than the
> > "rip it now" (because it makes things cleaner, easier to code, etc)
> > argument. 
> 
> The kernel development model (the whole stable/development tree thing)
> has changed based on the discussions at the kernel summit yesterday.
> See lwn.net for more details. That is why I sent this patch at this
> point in time.

Interesting, but we are not talking about an _internal_ API here.
It's about blocking the upgrade path. System using a stable kernel will
needlessly stop working after an upgrade to another stable kernel.

	Regards
		Oliver

