Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVGLUTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVGLUTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVGLUTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:19:44 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14332 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262368AbVGLUSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:18:49 -0400
Date: Tue, 12 Jul 2005 13:18:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Jim Nance <jlnance@sdf.lonestar.org>, Peter Staubach <staubach@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel header policy
Message-ID: <20050712201847.GD7741@smtp.west.cox.net>
References: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl> <42D3C51D.3020703@redhat.com> <20050712183859.GA21230@SDF.LONESTAR.ORG> <42D41545.7040809@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42D41545.7040809@lifl.fr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 09:08:53PM +0200, Eric Piel wrote:
> 12.07.2005 20:38, Jim Nance wrote/a écrit:
> >
> >
> >Perhaps a little history would help.  In the beginning, the kernel was
> >written with the intention that userland would be including the headers.
> >And libc did include the kernel headers.
> >
> >This did provide an effective way to get new kernel features to show
> >up in userland, but it created all sorts of other problems.  Eventually
> >it was decided/decreed that userland would NOT include kernel headers.
> >Instead, libc would provide a set of headers which would either be
> >compatable, or would marshel data into the form the kernel wanted.
> > 
> 
> So does this mean that all the "#ifdef __KERNEL__" are useless or are 
> they still used?

Because a large number of things aren't "fixed", __KERNEL__ is still
used so that nothing more breaks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
