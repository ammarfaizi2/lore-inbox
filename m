Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTE2IYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 04:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTE2IYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 04:24:50 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12808 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261994AbTE2IYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 04:24:49 -0400
Date: Thu, 29 May 2003 10:38:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030529083804.GA21673@alpha.home.local>
References: <20030529052425.GA1566@moonkingdom.net> <BKEGKPICNAKILKJKMHCAIEANECAA.Riley@Williams.Name> <20030529055735.GB1566@moonkingdom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529055735.GB1566@moonkingdom.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Wed, May 28, 2003 at 10:57:35PM -0700, Marc Wilson wrote:
> No, the basic problem there is that the kernel is deadlocking.  Read the
> VERY long thread for the details.

I didn't follow this thread, what's its subject, please ?
 
> I think I have enough on the ball to be able to tell the difference between
> mutt opening a folder and counting messages, with a counter and percentage
> indicator advancing, and mutt sitting there deadlocked with the HD activity
> light stuck on and all the rest of X stuck tight.

even on -rc3, I don't observe this behaviour. I tried from a cold cache, and
mutt took a little less than 3 seconds to open LKML's May folder (35 MB), and
progressed very smoothly. Since it's on my Alpha file server, I can't test
with X. But the I/O bandwidth and scheduler frequency (1024 HZ) may have an
impact.

Cheers,
Willy

