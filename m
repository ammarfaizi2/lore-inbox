Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWG0Igt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWG0Igt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWG0Igs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:36:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15309
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932151AbWG0Igs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:36:48 -0400
Date: Thu, 27 Jul 2006 01:37:07 -0700 (PDT)
Message-Id: <20060727.013707.101482735.davem@davemloft.net>
To: axboe@suse.de
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060727082924.GK5282@suse.de>
References: <20060727081114.GH5282@suse.de>
	<20060727.012037.78156999.davem@davemloft.net>
	<20060727082924.GK5282@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Thu, 27 Jul 2006 10:29:24 +0200

> Precisely. And this is the bit that is currently still broken for
> splice-to-socket, since it gives that ack right after ->sendpage() has
> been called. But that's a known deficiency right now, I think Alexey is
> currently looking at that (as well as receive side support).

That's right, I was discussing this with him just a few days ago.

It's good to hear that he's looking at those patches you were working
on several months ago.
