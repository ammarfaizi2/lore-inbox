Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVGSN3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVGSN3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVGSN3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:29:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261356AbVGSN2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:28:17 -0400
Date: Tue, 19 Jul 2005 14:27:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Dave Chinner <dgc@sgi.com>,
       greg@kroah.com, Nathan Scott <nathans@sgi.com>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
Message-ID: <20050719132750.GA20595@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
	Esben Nielsen <simlo@phys.au.dk>,
	Daniel Walker <dwalker@mvista.com>, Dave Chinner <dgc@sgi.com>,
	greg@kroah.com, Nathan Scott <nathans@sgi.com>,
	Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20050714160835.GA19229@infradead.org> <Pine.OSF.4.05.10507171848440.14250-100000@da410.phys.au.dk> <20050719032624.GA22060@nietzsche.lynx.com> <20050719123457.GC12368@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719123457.GC12368@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 02:34:57PM +0200, Ingo Molnar wrote:
> (I do disagree with Christoph on another point: i do think we eventually 
> want to change the standard semaphore type in a similar fashion upstream 
> as well - but that probably has to come with a s/struct semaphore/struct 
> mutex/ change as well.)

Actually having a mutex_t in mainline would be a good idea even without
preempt rt, to document better what kind of locking we expect.

