Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUHZR1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUHZR1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUHZRZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:25:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:42438 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269265AbUHZRWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:22:34 -0400
Date: Thu, 26 Aug 2004 18:22:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christophe Saout <christophe@saout.de>
Cc: Will Dyson <will_dyson@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826172221.GQ5733@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <412E10A2.1020801@pobox.com> <1093538653.5482.21.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093538653.5482.21.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> echo linux > file.bla/keywords/topic
> 
> The filesystem might then automatically put these keywords into an index
> and then provide a search mechanism elsewhere where it could ask "find
> me all dentries with the keyword 'linux'." and it would return a list
> like locate does. Only that it's in realtime and also works when moving
> the file around (but not when copying with an unaware program for
> obvious reasons).

It could work even when copying with an unaware program - provided
the're a tool which knows to extract metadata from files where that
hasn't been done already, or where the file's been modified.

-- Jamie




