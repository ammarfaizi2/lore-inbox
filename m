Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTBLEUj>; Tue, 11 Feb 2003 23:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBLEUj>; Tue, 11 Feb 2003 23:20:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50785 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266810AbTBLEUg>; Tue, 11 Feb 2003 23:20:36 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210164401.A11250@in.ibm.com>
	<1044896964.1705.9.camel@andyp.pdx.osdl.net>
	<m13cmwyppx.fsf@frodo.biederman.org> <20030211125144.A2355@in.ibm.com>
	<1044983092.1705.27.camel@andyp.pdx.osdl.net>
	<1045007213.1959.2.camel@andyp.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Feb 2003 21:29:59 -0700
In-Reply-To: <1045007213.1959.2.camel@andyp.pdx.osdl.net>
Message-ID: <m1k7g6xgs8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Tue, 2003-02-11 at 09:04, Andy Pfiffer wrote:
> > On Mon, 2003-02-10 at 23:21, Suparna Bhattacharya wrote:
> > <snip>
> > > The following patch from Anton Blanchard's WIP kexec tree 
> > > for ppc64 seems to fix this for me. It just does a use_mm() 
> > > (routine from fs/aio.c) instead of switch_mm(). 
> > > 
> > > Andy could you try this out and see if it helps  ?
> > > 
> > > The other change in Anton's tree that we should probably
> > > include uses a separate kexec_mm rather than init_mm
> > > for the mapping. 
> > > 
> > > Regards
> > > Suparna
> > 
> > Will do. --Andy
> 
> Answer: hard lock-up after decompressing the kernel.  I'll see if I can
> get anything meaningful out of the system before it wedges.

Which kernel is wedging.  The kexec'd kernel.  Or the kernel with
the patch?

Eric
