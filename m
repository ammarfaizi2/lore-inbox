Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276255AbRJYUrH>; Thu, 25 Oct 2001 16:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRJYUq4>; Thu, 25 Oct 2001 16:46:56 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:47243
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S276255AbRJYUqn>; Thu, 25 Oct 2001 16:46:43 -0400
Date: Thu, 25 Oct 2001 13:46:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: richard offer <offer@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export syscalls
Message-ID: <20011025134648.F29107@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <100000000.1004038404@changeling.engr.sgi.com> <200110252014.f9PKEpI22226@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110252014.f9PKEpI22226@ns.caldera.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:14:51PM +0200, Christoph Hellwig wrote:
> In article <100000000.1004038404@changeling.engr.sgi.com> you wrote:
> > * frm hch@caldera.de "10/25/2001 05:25:40 PM +0000" | sed '1,$s/^/* /'
> > *
> > * Hi Linus,
> > * 
> > * the appended patch exports the syscalls (GPL-limited), this is needed
> > * for the Linux-ABI modules so they can use the syscalls in their
> > * syscall tables for non-Linux personalities.
> >
> >
> > What is the rationale for marking these as GPL-exclusive symbols ? 
> >
> > I thought system calls were a public interface.
> 
> That won't change, but the syscalls are exported GPL-only for _inkernel_
> users.  My first version of the patch didn't do that, but people think
> that they can cause to much pain when used incorrectly, and that is
> checkable only with non-binary-only modules.

So since some people can't do something we should punish everyone?  If
binary-only module crashes and burns, other people aren't going to fix it
anyhow.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
