Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWHDSdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWHDSdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWHDSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:33:44 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61569 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751112AbWHDSdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:33:43 -0400
Date: Fri, 4 Aug 2006 11:34:48 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: A proposal - binary
Message-ID: <20060804183448.GE11244@sequoia.sous-sol.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803200136.GB28537@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> > Who said that?  Please smack them on the head with a broom.  We are all 
> > actively working on implementing Rusty's paravirt-ops proposal.  It 
> > makes the API vs ABI discussion moot, as it allow for both.
> 
> So everyone is still skirting the issue, oh great :)

No, we are working closely together on Rusty's paravirt ops proposal.
Given the number of questions I've fielded in the last 24 hrs, I really
don't think people understand this.

We are actively developing paravirt ops, we have a patch series that
begins to implement it (although it's still in it's nascent stage).  If
anybody is interested in our work it is done in public.  The working
tree is here: http://ozlabs.org/~rusty/paravirt/ (mercurial patchqueue,
just be forewarned that it's still quite early to be playing with it,
doesn't do much yet).  We are using the virtualization mailing list for
discussions https://lists.osdl.org/mailman/listinfo/virtualization if
you are interested.

Zach (please correct me if I'm wrong here), is working on plugging the
VMI into the paravirt_ops interface.  So his discussion of binary
interface issues is as a consumer of the paravirt_ops interface.

So, in case it's not clear, we are all working together to get
paravirt_ops upstream.  My personal intention is to do everything I can
to help get things in shape to queue for 2.6.19 inclusion, and having
confusion over our direction does not help with that agressive timeline.

thanks,
-chris
