Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVFFWWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVFFWWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVFFWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:21:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:27032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261731AbVFFWSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:18:22 -0400
Date: Mon, 6 Jun 2005 15:18:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: Chris Wright <chrisw@osdl.org>, Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11.11 Assertion failure in journal_commit_transaction()
Message-ID: <20050606221809.GK9407@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0506041304350.32405@diagnostix.dwd.de> <20050606134253.GB2130@atrey.karlin.mff.cuni.cz> <20050606181524.GA9153@shell0.pdx.osdl.net> <20050606221201.GB9649@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606221201.GB9649@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Kara (jack@suse.cz) wrote:
> > * Jan Kara (jack@suse.cz) wrote:
> > >   The kernel stopped because it detected a disk buffer in an unexpected
> > > state. 2.6.12-rc5 kernel should contain some more fixes than 2.6.11.11
> > > for similar problems so you can try that kernel. If you are able to see
> > > the same problem with 2.6.12-rc5 then let us know please.
> > 
> > Do you feel any of those fixes are stable enough for -stable?
> > Especially this one looks ok:
> > 
> >  Subject: [PATCH] Fix log_do_checkpoint() assertion failure
> >  Message-ID: <20050601074059.GD5933@atrey.karlin.mff.cuni.cz>
>    Yes, that patch should be safe and fixes a really observed bug so I
> guess it qualifies into -stable :)
> 

Thanks, I'll add to the -stable queue.
-chris
