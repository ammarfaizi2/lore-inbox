Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSJJVoE>; Thu, 10 Oct 2002 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbSJJVoD>; Thu, 10 Oct 2002 17:44:03 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:55984 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262409AbSJJVoA>; Thu, 10 Oct 2002 17:44:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] EVMS core (3/9) discover.c
Date: Thu, 10 Oct 2002 16:15:34 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler.suse.lists.linux.kernel> <02101014352905.17770@boiler.suse.lists.linux.kernel> <p73n0pmow9h.fsf@oldwotan.suse.de>
In-Reply-To: <p73n0pmow9h.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Message-Id: <0210101615340C.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 October 2002 15:48, Andi Kleen wrote:
> Kevin Corry <corryk@us.ibm.com> writes:
> > +
> > +	if (!gd) {
> > +		gd = alloc_disk();
> > +		BUG_ON(!gd);
>
> BUG_ON ? Can't this fail for legal reasons?

Yes, it can. This, and a couple other incorrect BUG_ON() statements have been 
fixed to fail gracefully. Thanks for catching this.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
