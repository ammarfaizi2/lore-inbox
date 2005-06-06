Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVFFWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVFFWSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVFFWOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:14:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38858 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261745AbVFFWML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:12:11 -0400
Date: Tue, 7 Jun 2005 00:12:01 +0200
From: Jan Kara <jack@suse.cz>
To: Chris Wright <chrisw@osdl.org>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11.11 Assertion failure in journal_commit_transaction()
Message-ID: <20050606221201.GB9649@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.61.0506041304350.32405@diagnostix.dwd.de> <20050606134253.GB2130@atrey.karlin.mff.cuni.cz> <20050606181524.GA9153@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606181524.GA9153@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Jan Kara (jack@suse.cz) wrote:
> >   The kernel stopped because it detected a disk buffer in an unexpected
> > state. 2.6.12-rc5 kernel should contain some more fixes than 2.6.11.11
> > for similar problems so you can try that kernel. If you are able to see
> > the same problem with 2.6.12-rc5 then let us know please.
> 
> Do you feel any of those fixes are stable enough for -stable?
> Especially this one looks ok:
> 
>  Subject: [PATCH] Fix log_do_checkpoint() assertion failure
>  Message-ID: <20050601074059.GD5933@atrey.karlin.mff.cuni.cz>
   Yes, that patch should be safe and fixes a really observed bug so I
guess it qualifies into -stable :)

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
