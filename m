Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUBQV0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266608AbUBQVZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:25:47 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:34057 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S266581AbUBQVXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:23:43 -0500
Date: Tue, 17 Feb 2004 21:23:38 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: matthew@sphinx.mythic-beasts.com
To: Jamie Lokier <jamie@shareable.org>
cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <20040217205707.GF24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402172119280.27679@sphinx.mythic-beasts.com>
References: <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
 <20040217164651.GB23499@mail.shareable.org> <yw1xr7wtcz0n.fsf@ford.guide>
 <20040217205707.GF24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Jamie Lokier wrote:

> No, I think hacking the terminal I/O is the best bet here.  Then _all_
> programs which currently work with UTF-8 terminals, which is rapidly
> becoming most of them, will work the same with both kinds of terminal,
> and the illusion of perfection will be complete and beautiful.

Yep.  A charset-translating tty proxy, a little like screen
or detachtty is what you want.  I wonder if there's an SSH
client or server which can do that.

Matthew.
