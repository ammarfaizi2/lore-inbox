Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWCWUmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWCWUmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWCWUmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:42:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47795 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422680AbWCWUmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:42:08 -0500
Date: Thu, 23 Mar 2006 15:41:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
Message-ID: <20060323204152.GO7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <1143145335.3147.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143145335.3147.52.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:22:15PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-03-23 at 14:59 -0500, Vivek Goyal wrote:
> 
> 
> > +			width, (unsigned long long) r->start,
> > +			width, (unsigned long long) r->end,
> 
> 
> hmmmm are there any platforms where unsigned long long is > 64 bits?

At least I am not aware of. Got to typecast it because ppc64 defines
u64 as unsigned long and compiler starts spitting warnings.

-Vivek
