Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbVGNQJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVGNQJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVGNQJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:09:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43201 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263051AbVGNQIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:08:49 -0400
Date: Thu, 14 Jul 2005 17:08:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Chinner <dgc@sgi.com>, greg@kroah.com,
       Nathan Scott <nathans@sgi.com>, Steve Lord <lord@xfs.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
Message-ID: <20050714160835.GA19229@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
	Dave Chinner <dgc@sgi.com>, greg@kroah.com,
	Nathan Scott <nathans@sgi.com>, Steve Lord <lord@xfs.org>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu> <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050714002246.GA937@frodo> <20050714135023.E241419@melbourne.sgi.com> <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050714052347.GA18813@elte.hu> <1121356618.14816.45.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121356618.14816.45.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 08:56:58AM -0700, Daniel Walker wrote:
> This reminds me of Documentation/stable_api_nonsense.txt . That no one
> should really be dependent on a particular kernel API doing a particular
> thing. The kernel is play dough for the kernel hacker (as it should be),
> including kernel semaphores.
> 
> So we can change whatever we want, and make no excuses, as long as we
> fix the rest of the kernel to work with our change. That seems pretty
> sensible , because Linux should be an evolution. 

Daniel, get a fucking clue.  Read some CS 101 literature on what a semaphore
is defined to be.  If you want PI singing dancing blinking christmas tree
locking primites call them a mutex, but not a semaphore.

