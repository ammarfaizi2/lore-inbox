Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVATNQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVATNQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVATNQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:16:02 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:39942 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262142AbVATNP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:15:58 -0500
Date: Thu, 20 Jan 2005 14:15:56 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: oom killer gone nuts
Message-ID: <20050120131556.GC10457@pclin040.win.tue.nl>
References: <20050120123402.GA4782@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120123402.GA4782@suse.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:34:06PM +0100, Jens Axboe wrote:

> Using current BK on my x86-64 workstation, it went completely nuts today
> killing tasks left and right with oodles of free memory available.

Yes, the fact that the oom-killer exists is a serious problem.
People work on trying to tune it, instead of just removing it.

I am getting reports that also in overcommit mode 2 (no overcommit,
no oom-killer ever needed) processes are killed by the oom-killer
(on 2.6.10).

Andries
