Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265366AbSJRWkE>; Fri, 18 Oct 2002 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSJRWkE>; Fri, 18 Oct 2002 18:40:04 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:55033 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S265366AbSJRWkD>; Fri, 18 Oct 2002 18:40:03 -0400
Date: Fri, 18 Oct 2002 15:36:50 -0700
From: Chris Wright <chris@wirex.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018153650.G26442@figure1.int.wirex.com>
Mail-Followup-To: Stephen Smalley <sds@tislabs.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021018173339.A7481@infradead.org> <Pine.GSO.4.33.0210181239310.9847-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.33.0210181239310.9847-100000@raven>; from sds@tislabs.com on Fri, Oct 18, 2002 at 01:15:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tislabs.com) wrote:
> 
> On Fri, 18 Oct 2002, Christoph Hellwig wrote:
> 
> > It adds infrastructure to implement syscalls without peer review.
> > And then it ends being crap like the selinux syscalls.
> 
> Yes, I think you've made your point.  Go ahead, remove sys_security.

Looks like we should remove this.  The interface is awkward, and there
are many examples of how it's not needed and is broken by design.  I know
SubDomain can get by without it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
