Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJQUEv>; Thu, 17 Oct 2002 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbSJQUEv>; Thu, 17 Oct 2002 16:04:51 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32782 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261555AbSJQUEu>;
	Thu, 17 Oct 2002 16:04:50 -0400
Date: Thu, 17 Oct 2002 13:10:31 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017201030.GA384@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017210402.A7741@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 09:04:02PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 17, 2002 at 12:07:23PM -0700, Greg KH wrote:
> > But this will require every security module project to petition for a
> > syscall, which would be a pain, and is the whole point of having this
> > sys_security call.
> 
> And the whole point of the reemoval is to not make adding syscalls
> easy.  Adding a syscall needs review and most often you actually want
> a saner interface.

Ok, I think it's time for someone who actually cares about the security
syscall to step up here to try to defend the existing interface.  I'm
pretty sure Ericsson, HP, SELinux, and WireX all use this, so they need
to be the ones defending it.

> > How would they be done differently now?  Multiple different syscalls?
> 
> Yes.

Hm, in looking at the SELinux documentation, here's a list of the
syscalls they need:
	http://www.nsa.gov/selinux/docs2.html

That's a lot of syscalls :)

thanks,

greg k-h
