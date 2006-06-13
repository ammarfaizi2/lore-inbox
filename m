Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752328AbWFMFpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbWFMFpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbWFMFpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:45:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18485 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1752327AbWFMFpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:45:44 -0400
Date: Tue, 13 Jun 2006 07:46:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Vishal Patil <vishpat@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CSCAN vs CFQ I/O scheduler benchmark results
Message-ID: <20060613054609.GR4420@suse.de>
References: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com> <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com> <20060611185854.GF13556@suse.de> <4745278c0606111647g7ca1392bjb46936f69d6b668d@mail.gmail.com> <20060612064136.GB4420@suse.de> <4745278c0606121038y7fcdab2q33a9065e9071938b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745278c0606121038y7fcdab2q33a9065e9071938b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12 2006, Vishal Patil wrote:
> Jens
> 
> Could you let me know what tests would be fair to make comparsion
> between the I/O schedulers? Thanks.

Depends on what you want to test, of course! I can't give you an answer
on that.

The thing about IO schedulers is that it's easy to provide good
throughput or good latency, but hard to do both. The tests you did so
far have x processes doing the same thing. Try something that has eg an
async writer going full throttle, and then a/some sync readers.

-- 
Jens Axboe

