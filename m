Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVDERuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVDERuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVDERtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:49:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:21169 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261848AbVDER27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:28:59 -0400
Date: Tue, 5 Apr 2005 10:28:43 -0700
From: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [00/11] -stable review
Message-ID: <20050405172843.GA17915@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hm, sorry about the wrong subject, there were only 8 patches.

And here's a diffstat of all of them, just to make this email worth
reading and not just an apology:

 lib/rwsem-spinlock.c          |   42 ++++++++++++++++++++++++++----------------
 lib/rwsem.c                   |   16 ++++++++++------
 net/ipv4/xfrm4_output.c       |   12 ++++++------
 net/ipv6/xfrm6_output.c       |   12 ++++++------
 arch/um/kernel/skas/uaccess.c |    3 ++-
 arch/ia64/kernel/fsys.S       |    4 +++-
 arch/ia64/kernel/signal.c     |    3 ++-
 net/ipv4/tcp_input.c          |    5 ++++-
 fs/jbd/transaction.c          |    6 +++---
 drivers/i2c/chips/eeprom.c    |    3 ++-
 sound/core/timer.c            |    5 ++++-
 11 files changed, 68 insertions(+), 43 deletions(-)

thanks,

greg k-h
