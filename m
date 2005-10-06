Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVJFSsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVJFSsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVJFSsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:48:30 -0400
Received: from nevyn.them.org ([66.93.172.17]:2733 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751294AbVJFSs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:48:29 -0400
Date: Thu, 6 Oct 2005 14:48:18 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] atomic create+open
Message-ID: <20051006184818.GA30137@nevyn.them.org>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Miklos Szeredi <miklos@szeredi.hu>, trond.myklebust@fys.uio.no,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu> <1128616864.8396.32.camel@lade.trondhjem.org> <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu> <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu> <1128619526.16534.8.camel@lade.trondhjem.org> <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu> <1128620528.16534.26.camel@lade.trondhjem.org> <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu> <20051006180006.GB19766@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006180006.GB19766@mail.shareable.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 07:00:06PM +0100, Jamie Lokier wrote:
> Miklos Szeredi wrote:
> > > Secondly, Linux doesn't actually allow bind mounts on top of regular
> > > files.
> > 
> > It does.  Try it.
> 
> The feature is even useful from time to time.

But very limited... the last time I needed something like this, bind
mounts on files were so awkward that I ended up solving the problem in
FUSE instead.  Explanation at:

  http://return.false.org/~drow/fuse/

-- 
Daniel Jacobowitz
CodeSourcery, LLC
