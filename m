Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272530AbTGaPUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272501AbTGaPUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:20:14 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:13069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272530AbTGaPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:20:05 -0400
Date: Thu, 31 Jul 2003 16:20:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] dm: decimal device num sscanf
Message-ID: <20030731162000.A15112@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <thornber@sistina.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk> <20030731104953.GG394@fib011235813.fsnet.co.uk> <20030731160429.A14613@infradead.org> <20030731151326.GZ394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030731151326.GZ394@fib011235813.fsnet.co.uk>; from thornber@sistina.com on Thu, Jul 31, 2003 at 04:13:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 04:13:26PM +0100, Joe Thornber wrote:
> > This code should just go away completly.  There's no excuse for parsing
> > a dev_t in new code instead of a pathname.
> 
> It's in there to match the output from 'dmsetup table'.  I'm not sure
> anyone uses it, but I'd still like to keep it so that 2.4 and 2.6 stay
> in sync.

Please do the matching from dev_t to pathname in userspace.

