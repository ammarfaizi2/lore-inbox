Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWFPMyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFPMyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWFPMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:54:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:28829 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751387AbWFPMyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 08:54:09 -0400
Date: Fri, 16 Jun 2006 07:54:03 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-ID: <20060616125403.GA16194@sergelap.austin.ibm.com>
References: <17553.56625.612931.136018@cargo.ozlabs.ibm.com> <1150419895.10290.9.camel@localhost.localdomain> <20060616030432.GA18037@sergelap.austin.ibm.com> <1150430429.10290.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150430429.10290.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rusty Russell (rusty@rustcorp.com.au):
> On Thu, 2006-06-15 at 22:04 -0500, Serge E. Hallyn wrote:
> > Quoting Rusty Russell (rusty@rustcorp.com.au):
> > > Seems like change for change's sake, to me, *and* it added more code
> > > than it removed.
> > 
> > So if kernel_thread is really going to be removed, how else should this
> > be done?  Just clone?
> 
> Sorry, is kernel_thread going to be removed, or just not exported to
> modules?  What's kthread going to use?
> 
> Confused,
> Rusty.

Hah.

Yes, I see.  I misread.  So I should be focusing on modules  :)

Really, all *I* care about is cases where the resulting pid is cached
as a pointer to the thread, which it wasn't here anyway.  

thanks, sorry for the noise.

-serge
