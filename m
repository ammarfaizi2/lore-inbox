Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbUJYPTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUJYPTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUJYPTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:19:38 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:59916 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261948AbUJYPQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:16:22 -0400
Date: Mon, 25 Oct 2004 16:16:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 8/28] VFS: Remove MNT_EXPIRE support
Message-ID: <20041025151621.GA1805@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <Michael.Waychison@Sun.COM>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987153211852@sun.com> <10987153522992@sun.com> <20041025150446.GB1603@infradead.org> <417D17C0.3010202@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417D17C0.3010202@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 11:12:00AM -0400, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Christoph Hellwig wrote:
> > On Mon, Oct 25, 2004 at 10:42:32AM -0400, Mike Waychison wrote:
> > 
> >>Drop support for MNT_EXPIRE (flag to umount(2)).  Nobody was using it and it
> >>didn't fit into the new expiry framework.
> > 
> > 
> > umm, this is a user API, you can't simply drop it.
> > 
> 
> Is anybody using it though?

doesn't matter much.  Maybe Sun likes deliberately breaking user ABIs in
Solaris, but in Linux we certainly don't.

> Hmm.  I'll think about it a while to figure out how to map this
> functionality to the new expire semantics.  Any suggestions?

Hey, it's you who wants the new semantics.  And you didn't even explain
them in detail.

