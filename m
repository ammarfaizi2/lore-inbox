Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVKFS5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVKFS5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 13:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKFS5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 13:57:40 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:64656 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932181AbVKFS5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 13:57:40 -0500
Subject: Re: Problem with the default IOSCHED
From: Marcel Holtmann <marcel@holtmann.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051102115542.GN26049@suse.de>
References: <1130891282.5048.50.camel@blade>
	 <20051102115542.GN26049@suse.de>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 19:57:38 +0100
Message-Id: <1131303458.5824.1.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

> > by accident I selected the anticipatory IO scheduler as default in my
> > kernel config, but only the CFQ was built in. The anticipatory and
> > deadline were only available as modules. This caused an oops at boot.
> > After selecting CFQ as default schedule and a recompile and reboot
> > everything was fine again.
> 
> Hmm yes, that looks like a bug introduced with the io scheduler
> selection reorg. There's really no support in place for requesting this
> module out of initrd, I'd rather just make your selection illegal. Does
> this work for you?

the patch looks good and please get this out to Linus, because I just
made the same mistake on another machine.

Regards

Marcel


