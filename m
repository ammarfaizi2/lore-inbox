Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUFFRAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUFFRAI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFFRAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:00:08 -0400
Received: from [213.146.154.40] ([213.146.154.40]:52931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263823AbUFFRAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:00:03 -0400
Date: Sun, 6 Jun 2004 18:00:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040606170001.GA10258@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <9025E129D3FCD340A7BA67E342D10E7AF11B72@proxy.mse1.mailstreet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9025E129D3FCD340A7BA67E342D10E7AF11B72@proxy.mse1.mailstreet.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 11:53:43AM -0400, Peter J. Braam wrote:
> Perhaps it is useful to explain that vendors (Novell, Dell, HP and
> others) have urged me to enquire if the hooks could go into 2.6.  All of
> them have really major Lustre customers, running top10 super computing
> clusters with Lustre.  Having the hooks avoids having to patch vendor
> kernels, which breaks support arrangements.  As for our position, it's
> in fact easier to wait and just collect clever insights from time to
> time. 
> 
> I represent them here.  I understand and would respect the wait until
> 2.7 argument, but I think it is workable to get them into 2.6.  Is it
> really a big deal to go through these small patches a few more times to
> judge if they are safe, and to include them?  I think it would help
> people who care and support Linux financically.  I only hear Christoph
> arguing against it, are there other insights?

Trond also clearly spoke against it and Anton didn't seem to be impressed
by the code quality of your patches either ;-)  Only lmb who certainly
has a vested interest by beeing responsible for cluster at one of the above
mentioned vendors has speaken for it.  Given that SLES9 will already have
lustre life should already be much simpler for you.  If clusterfs is
actually interested in maintaining lustre as part of the linux kernel I'm
the last one to object, but without you place the burden of maintaining
all the hooks that are very specific to your filesystem on us.

p.s. where's lustre's current cvs tree?  I'd like to actually build a module
vs the hooks that you posted and growel in the cvs history a little. 
