Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272541AbTGaP2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272546AbTGaP1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:27:14 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:50180 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272541AbTGaPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:24:56 -0400
Date: Thu, 31 Jul 2003 16:24:54 +0100
From: Joe Thornber <thornber@sistina.com>
To: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@sistina.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] dm: decimal device num sscanf
Message-ID: <20030731152454.GA394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk> <20030731104953.GG394@fib011235813.fsnet.co.uk> <20030731160429.A14613@infradead.org> <20030731151326.GZ394@fib011235813.fsnet.co.uk> <20030731162000.A15112@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731162000.A15112@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 04:20:00PM +0100, Christoph Hellwig wrote:
> On Thu, Jul 31, 2003 at 04:13:26PM +0100, Joe Thornber wrote:
> > > This code should just go away completly.  There's no excuse for parsing
> > > a dev_t in new code instead of a pathname.
> > 
> > It's in there to match the output from 'dmsetup table'.  I'm not sure
> > anyone uses it, but I'd still like to keep it so that 2.4 and 2.6 stay
> > in sync.
> 
> Please do the matching from dev_t to pathname in userspace.

we do.
