Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUK3WEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUK3WEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUK3WEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:04:10 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:51411 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S261262AbUK3WEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:04:08 -0500
Date: Tue, 30 Nov 2004 23:04:10 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/via-rhine: convert MODULE_PARM to module_param
Message-ID: <20041130220410.GB29947@k3.hellgate.ch>
References: <Pine.LNX.4.61.0411300053190.3432@dragon.hygekrogen.localhost> <20041130140309.GA6568@k3.hellgate.ch> <Pine.LNX.4.61.0411302241260.3635@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411302241260.3635@dragon.hygekrogen.localhost>
X-Operating-System: Linux 2.6.10-rc2-bk11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 22:44:37 +0100, Jesper Juhl wrote:
> already moved to module_param().  There's one difference though, and I 
> think it matters; my patch sets the permission bits so that the parameters 
> get exposed in sysfs (which I think is very useful), the driver in -mm 
> sets the perms to 0 (zero) so nothing is exposed in sysfs (less useful).

I am not familiar with the issue. Can you work out with the submitter of
the -mm patch why it was coded that way, and if your version is better?

Roger
