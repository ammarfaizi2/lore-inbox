Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUBXUJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbUBXUJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:09:07 -0500
Received: from intra.cyclades.com ([64.186.161.6]:43924 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262435AbUBXUIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:08:39 -0500
Date: Tue, 24 Feb 2004 18:00:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Philippe Troin <phil@fifi.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] Nfs lost locks
In-Reply-To: <87wu6cckys.fsf@ceramic.fifi.org>
Message-ID: <Pine.LNX.4.58L.0402241757130.23951@logos.cnet>
References: <87k72h17n7.fsf@ceramic.fifi.org> <Pine.LNX.4.58L.0402241607500.23951@logos.cnet>
 <87wu6cckys.fsf@ceramic.fifi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Feb 2004, Philippe Troin wrote:

> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
>
> > On Fri, 20 Feb 2004, Philippe Troin wrote:
> >
> > > The NFS client is prone to loose locks on filesystems when the locking
> > > process is killed with a signal. This has been discussed on the nfs
> > > mailing list in these threads:
> > >
> > >   http://sourceforge.net/mailarchive/forum.php?thread_id=3213117&forum_id=4930
> > >
> > >   http://marc.theaimsgroup.com/?l=linux-nfs&m=107074045907620&w=2
> > >
> > > Marcelo, if the above links are not sufficient, please email back for
> > > more details.
> > >
> > > The enclosed patch is from Trond, and it fixes the problem.
> >
> > Hi Philippe,
> >
> > It might be wise to wait for the patch to be in 2.6 first?
> >
> > Trond, what do you think?
>
> I do not know about the 2.6.x status, but Trond requested help with
> pushing this patch to the kernel, mentionning he was very busy with
> NFSv4.
>
> I personnaly think it fixes a serious problem with file locking on
> NFS, but that's my assessment.

I also think it fixes a serious problem with file locking on NFS. What I
dont think is that it has been extensively tested (I seen you stressed
file locking with it for a couple of days, but thats not enough).

I feel that it needs to get tested on different setups.

If Trond is confident it works reliably, I will apply it right away.
