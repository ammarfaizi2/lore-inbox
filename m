Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVKIKMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVKIKMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVKIKMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:12:52 -0500
Received: from gate.in-addr.de ([212.8.193.158]:9454 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932479AbVKIKMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:12:52 -0500
Date: Wed, 9 Nov 2005 11:12:21 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>
Cc: Neil Brown <neilb@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: userspace block driver?
Message-ID: <20051109101221.GM15967@marowsky-bree.de>
References: <4371A4ED.9020800@pobox.com> <17265.42782.188870.907784@cse.unsw.edu.au> <4371A944.6070302@pobox.com> <20051109075455.GN3699@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051109075455.GN3699@suse.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-11-09T08:54:56, Jens Axboe <axboe@suse.de> wrote:

> > >>Has anybody put any thought towards how a userspace block driver
						^^^^^^^^^
> > >>would work?
> 
> I was going to say drbd, but then you did say more lightweight :-)
		     ^^^^

drbd is implemented all in-kernel, too.

The deadlock scenarios with running block IO through user-space are
still somewhat unsolved, though. Not that block over network IO (in
particular TCP) is much better even when implemented in-kernel...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

