Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424446AbWKPUjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424446AbWKPUjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424454AbWKPUjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:39:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:59799 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1424446AbWKPUjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:39:53 -0500
Date: Thu, 16 Nov 2006 14:39:46 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Alan Cox <alan@redhat.com>,
       "Ryan S. Arnold" <rsa@us.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-ID: <20061116203946.GA23600@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com> <1163635387.8805.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163635387.8805.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 11:03:07AM +1100, Michael Ellerman wrote:
> On Wed, 2006-11-15 at 15:26 -0600, Linas Vepstas wrote:
> > 
> > This is a non-urgent patch. 
> > 
> > I can't figure out who the upstream maintainer for char drivers 
> > is supposed to be. Can this patch be applied? 
> > 
> > --linas
> > 
> > This patch removes an pair of irritating compiler warnings:
> > 
> > drivers/char/hvcs.c:1605: warning: ignoring return value of
> > sysfs_create_group declared with attribute warn_unused_result
> > drivers/char/hvcs.c:1639: warning: ignoring return value of
> > driver_create_file declared with attribute warn_unused_result
> > 
> > Doing this required moving a big block of code from the bottom 
> > of the file to the top, so as to avoid the need for (irritating) 
> > forward declarations.
> 
> Can you do the move and the fix as two patches? It's very hard to review
> in its current form.

Sorry, coming shortly. -- linas

