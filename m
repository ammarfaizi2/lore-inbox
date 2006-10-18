Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWJRMnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWJRMnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWJRMnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:43:42 -0400
Received: from brick.kernel.dk ([62.242.22.158]:1868 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030254AbWJRMnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:43:41 -0400
Date: Wed, 18 Oct 2006 14:44:20 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018124420.GI24452@kernel.dk>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161175344.9363.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Alan Cox wrote:
> Bandwidth is completely silly in this context, iops/sec is merely
> hopeless 8)

Both need the disk to play nicely, if you get into error handling or
correction, you get screwed. Bandwidth by itself is meaningless, you
need latency as well to make sense of it.

-- 
Jens Axboe

