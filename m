Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314438AbSDRTcr>; Thu, 18 Apr 2002 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314437AbSDRTcq>; Thu, 18 Apr 2002 15:32:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60613 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314436AbSDRTcp>; Thu, 18 Apr 2002 15:32:45 -0400
Date: Thu, 18 Apr 2002 15:32:38 -0400
From: Doug Ledford <dledford@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, jh@suse.cz,
        linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de, ak@suse.de,
        pavel@atrey.karlin.mff.cuni.cz,
        References: 
	20020417194249.B23438@redhat.com,
        20020418072615.I14322@dualathlon.random
Subject: Re: SSE related security hole
Message-ID: <20020418153238.A25037@redhat.com>
Mail-Followup-To: Doug Ledford <dledford@redhat.com>,
	Pavel Machek <pavel@suse.cz>, Andrea Arcangeli <andrea@suse.de>,
	jh@suse.cz, linux-kernel@vger.kernel.org, jakub@redhat.com,
	aj@suse.de, ak@suse.de, pavel@atrey.karlin.mff.cuni.cz,
	References:  20020417194249.B23438@redhat.com,
	20020418072615.I14322@dualathlon.random
In-Reply-To: <20020418072615.I14322@dualathlon.random> <20020418094444.A2450@redhat.com> <20020418192003.GE11220@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 09:20:03PM +0200, Pavel Machek wrote:
> It introduces security hole: Unrelated tasks now have your top secret
> value you stored in one of your registers.

Well, that's been my point all along and why I sent the patch.  I was not 
asking why leaving the registers alone instead of 0ing them out was not a 
security hole.  I was asking why doing so was not backward compatible?

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
