Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbSJGSLu>; Mon, 7 Oct 2002 14:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbSJGSLu>; Mon, 7 Oct 2002 14:11:50 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:15122 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262600AbSJGSLt>; Mon, 7 Oct 2002 14:11:49 -0400
Date: Mon, 7 Oct 2002 19:17:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <efault@gmx.de>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: bcopy()
Message-ID: <20021007191726.A23246@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Mike Galbraith <efault@gmx.de>, Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20021007195409.00b54a98@pop.gmx.net> <Pine.LNX.4.33.0210071105350.21165-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210071105350.21165-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 07, 2002 at 11:08:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:08:19AM -0700, Linus Torvalds wrote:
> So I'd much rather see the XFS etc code moved away from bcopy() first,
> because that's the _real_ cleanup. The library code isn't all that ugly in
> comparison.

The lowlevel XFS code tries to stay in sync as much as possible with
the IRIX codebase to make maintaince easier (we're a very small team..).

It could be removed, but I don't think it would help..

