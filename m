Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279378AbRKARGe>; Thu, 1 Nov 2001 12:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279377AbRKARGY>; Thu, 1 Nov 2001 12:06:24 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:36750 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S279372AbRKARGR>; Thu, 1 Nov 2001 12:06:17 -0500
Date: Thu, 1 Nov 2001 18:06:03 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-ID: <20011101180603.B14165@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <E15zF9H-0000NL-00@wagner> <3BE1271C.6CDF2738@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3BE1271C.6CDF2738@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 05:42:36AM -0500, Jeff Garzik wrote:
> >         proc(KBUILD_OBJECT, "foo", my_foo, int, 0644);
> > 
> > And with my previous parameter patch:
> >         PARAM(foo, int, 0444);
> 
> Is this designed to replace sysctl?
> 
> In general we want to support using sysctl and similar features WITHOUT
> procfs support at all (of any type).  Nice for embedded systems
> especially.

Agreed. It would be nice to have always 1:1 relation between sysctl and
procfs interface, so you can do EVERYTHING with both of sysctl and via
/proc ... Maybe the code should be partly common as much as possible as well.

- Gabor
