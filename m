Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265156AbTLCUO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTLCUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:14:58 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:12687 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S265156AbTLCUO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:14:27 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
	<20031203183719.GD24651@dualathlon.random>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 03 Dec 2003 15:14:24 -0500
In-Reply-To: <20031203183719.GD24651@dualathlon.random> (Andrea Arcangeli's
 message of "Wed, 3 Dec 2003 19:37:19 +0100")
Message-ID: <9cfu14hbqvz.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> It's probably going to work an order of magnitude better thanks
> especially to the lower_zone_reserve algorithm.
>
> However I'd still recommend to use my tree, the last two critical bits
> you need from my tree are inode-highmem and related_bhs. Those two are
> still missing, and you probably need them with 12G.
>
> I'm going to release a 2.4.23aa1 btw, that will be the last 2.4-aa.

I found 10_inode-highmem-2 in the 2.4.23pre6aa3 directory, but I
couldn't find any related_bhs one.  Am I looking in the wrong place?

I'd wait for -aa1, but I want to try the updated aic7xxx driver in 2.4.23
sooner rather than later.

Ian

