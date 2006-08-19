Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWHSEyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWHSEyy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 00:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWHSEyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 00:54:54 -0400
Received: from 1wt.eu ([62.212.114.60]:30224 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750702AbWHSEyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 00:54:54 -0400
Date: Sat, 19 Aug 2006 06:45:33 +0200
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andreas Steinmetz <ast@domdv.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060819044533.GB24543@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <20060817090651.GP7813@stusta.de> <44E433DB.9090501@domdv.de> <20060818232501.GE7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818232501.GE7813@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 01:25:01AM +0200, Adrian Bunk wrote:
> On Thu, Aug 17, 2006 at 11:16:11AM +0200, Andreas Steinmetz wrote:
> > Adrian Bunk wrote:
> > > Can you send me the .config's you are using for 2.4 and 2.6 
> > > (preferably for kernel.org kernels)?
> > > 
> > 
> > I can send you only the current 2.4 config I use (not exactly vanilla).
> 
> Thanks, but it didn't help me much since it needed some work getting it 
> compiling with uClinux-2.4.31-uc0, and the next step of creating a 
> functionally equivalent 2.6 kernel doesn't seem to be reasonably 
> possible.

In his case, it is a very valid reason to stay on 2.4 right now, which
was the original question IIRC.

> My aim is to compare the size of the compiled objects for finding what 
> causes size regressions in 2.6 compared to 2.4.

Sometimes it will be compilers, but not by that much. Gcc3.[34] generally
produce bigger code than 2.95 at -O2, but I don't think that people in the
embedded world still use 2.95 much.

Cheers,
Willy

