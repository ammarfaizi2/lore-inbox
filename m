Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVFFSQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFFSQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVFFSQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:16:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:9915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbVFFSPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:15:38 -0400
Date: Mon, 6 Jun 2005 11:15:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11.11 Assertion failure in journal_commit_transaction()
Message-ID: <20050606181524.GA9153@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0506041304350.32405@diagnostix.dwd.de> <20050606134253.GB2130@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606134253.GB2130@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Kara (jack@suse.cz) wrote:
>   The kernel stopped because it detected a disk buffer in an unexpected
> state. 2.6.12-rc5 kernel should contain some more fixes than 2.6.11.11
> for similar problems so you can try that kernel. If you are able to see
> the same problem with 2.6.12-rc5 then let us know please.

Do you feel any of those fixes are stable enough for -stable?
Especially this one looks ok:

 Subject: [PATCH] Fix log_do_checkpoint() assertion failure
 Message-ID: <20050601074059.GD5933@atrey.karlin.mff.cuni.cz>

thanks,
-chris
