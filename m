Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUBVQ2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUBVQ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:28:54 -0500
Received: from mail.shareable.org ([81.29.64.88]:2178 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261693AbUBVQ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:28:53 -0500
Date: Sun, 22 Feb 2004 16:28:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040222162848.GC25664@mail.shareable.org>
References: <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <20040217164651.GB23499@mail.shareable.org> <yw1xr7wtcz0n.fsf@ford.guide> <20040217205707.GF24311@mail.shareable.org> <Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com> <20040217214733.GJ24311@mail.shareable.org> <m1vflzjfk5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vflzjfk5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> I guess my question is when do we know the information is going to
> a terminal so we should translate it?

When a program is writing to a terminal device, then we know it's
going to a terminal _or_ to a program which is pretending to be one
(pseudo-terminal).  Either way, the behaviour should be the same

The "screen" program can be used to do translation, although it's a
rather cumbersome way to go about it, and it has other effects which
are annoying (at least one key is always designated for "screen" commands).

-- Jamie
