Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbTBKXhN>; Tue, 11 Feb 2003 18:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbTBKXhN>; Tue, 11 Feb 2003 18:37:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267963AbTBKXhK>;
	Tue, 11 Feb 2003 18:37:10 -0500
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
From: Andy Pfiffer <andyp@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
In-Reply-To: <1044983092.1705.27.camel@andyp.pdx.osdl.net>
References: <3E448745.9040707@mvista.com>
	 <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com>
	 <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210164401.A11250@in.ibm.com>
	 <1044896964.1705.9.camel@andyp.pdx.osdl.net>
	 <m13cmwyppx.fsf@frodo.biederman.org>  <20030211125144.A2355@in.ibm.com>
	 <1044983092.1705.27.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1045007213.1959.2.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 11 Feb 2003 15:46:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 09:04, Andy Pfiffer wrote:
> On Mon, 2003-02-10 at 23:21, Suparna Bhattacharya wrote:
> <snip>
> > The following patch from Anton Blanchard's WIP kexec tree 
> > for ppc64 seems to fix this for me. It just does a use_mm() 
> > (routine from fs/aio.c) instead of switch_mm(). 
> > 
> > Andy could you try this out and see if it helps  ?
> > 
> > The other change in Anton's tree that we should probably
> > include uses a separate kexec_mm rather than init_mm
> > for the mapping. 
> > 
> > Regards
> > Suparna
> 
> Will do. --Andy

Answer: hard lock-up after decompressing the kernel.  I'll see if I can
get anything meaningful out of the system before it wedges.

Andy


