Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267897AbTBLWWZ>; Wed, 12 Feb 2003 17:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBLWWV>; Wed, 12 Feb 2003 17:22:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:43497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267897AbTBLWWM>;
	Wed, 12 Feb 2003 17:22:12 -0500
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
In-Reply-To: <m1k7g6xgs8.fsf@frodo.biederman.org>
References: <3E448745.9040707@mvista.com>
	 <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com>
	 <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210164401.A11250@in.ibm.com>
	 <1044896964.1705.9.camel@andyp.pdx.osdl.net>
	 <m13cmwyppx.fsf@frodo.biederman.org> <20030211125144.A2355@in.ibm.com>
	 <1044983092.1705.27.camel@andyp.pdx.osdl.net>
	 <1045007213.1959.2.camel@andyp.pdx.osdl.net>
	 <m1k7g6xgs8.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: 
Message-Id: <1045089117.1502.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 14:31:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 20:29, Eric W. Biederman wrote:
> Andy Pfiffer <andyp@osdl.org> writes:
> 
> > On Tue, 2003-02-11 at 09:04, Andy Pfiffer wrote:
> > > On Mon, 2003-02-10 at 23:21, Suparna Bhattacharya wrote:
> > > <snip>
> > > > The following patch from Anton Blanchard's WIP kexec tree 
> > > > for ppc64 seems to fix this for me. It just does a use_mm() 
> > > > (routine from fs/aio.c) instead of switch_mm(). 
> > > > 
> > > > Andy could you try this out and see if it helps  ?
> > > > 
<snip>
> > > > Regards
> > > > Suparna
> > > 
> > > Will do. --Andy
> > 
> > Answer: hard lock-up after decompressing the kernel.  I'll see if I can
> > get anything meaningful out of the system before it wedges.
> 
> Which kernel is wedging.  The kexec'd kernel.  Or the kernel with
> the patch?
> 
> Eric

Correction: this patch is now working for me.  While pruning my .config
to debug my serial console problem, kexec worked on a 2-way for me
several times in a row without failure.  (I hadn't properly updated my
script that invokes kexec with my preferred command line arguments).

I'll add the patchlet to our PLM system, and try the entire package
again on 2.5.60 on a 2-way.

Andy





