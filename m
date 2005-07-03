Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVGCBps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVGCBps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 21:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVGCBps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 21:45:48 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:20638 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261174AbVGCBpk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 21:45:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7VwNKpy7GAQArQpz8YQ040wH1UipTdRYhRPqdUbnx0mwObDIvDSybKWlNkpD88Fls5viX3qKZ70LcoKKsRO0vGJzdWL2Xh5m6SeNzqMNfy++nwfCHHugLCGEbjaxUXAB4kmjI/ptXJsOJ9NA3DYz0cfSYwNquQmkKlhcEIGTS8=
Message-ID: <a728f9f905070218459cd140@mail.gmail.com>
Date: Sat, 2 Jul 2005 21:45:40 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [Jfs-discussion] jfs mount causes oops on sparc64
Cc: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ag@m-cam.com
In-Reply-To: <1120345779.9901.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a728f9f905070111133a24590@mail.gmail.com>
	 <1120345779.9901.6.camel@kleikamp.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/05, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Fri, 2005-07-01 at 14:13 -0400, Alex Deucher wrote:
> > I have a 6.9 TB jfs LVM volume on a sparc64 debian box, however mount
> > seems to cause an oops when I attempt to mount the volume:
> >
> > jfs_mount: diMount(ipaimap) failed w/rc = -5
> > data_access_exception: SFSR[0000000000801009] SFAR[000000000043f770], going.
> 
> > kernel is 2.6.12rc3 on debian sparc.  Any ideas?
> 
> JFS has never worked on architectures with a page size greater than 4K
> until (would you believe?) 2.6.12-rc4.  I bet if you would try a more
> recent kernel, you would no longer see this problem.
> 
> In case you would continue to see problems with a newer kernel, I'd like
> to know.  I'll be on vacation until July 13, so my email access will be
> sporadic.
> 

I too will be on vacation until July 17th, but thanks for the heads
up!  We should probably upgrade that box to the latest 2.6.12 kernel
anyway.

Thanks,

Alex

> Thanks,
> Shaggy
> --
> David Kleikamp
> IBM Linux Technology Center
> 
>
