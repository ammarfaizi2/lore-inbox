Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUDNV0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUDNV0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:26:01 -0400
Received: from tantale.fifi.org ([216.27.190.146]:27264 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261817AbUDNVZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:25:58 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nfs lost locks
References: <87k72h17n7.fsf@ceramic.fifi.org>
	<Pine.LNX.4.58L.0402241607500.23951@logos.cnet>
	<87wu6cckys.fsf@ceramic.fifi.org>
	<Pine.LNX.4.58L.0402241757130.23951@logos.cnet>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 14 Apr 2004 14:25:56 -0700
In-Reply-To: <Pine.LNX.4.58L.0402241757130.23951@logos.cnet>
Message-ID: <87isg2ntej.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> On Tue, 24 Feb 2004, Philippe Troin wrote:
> 
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> >
> > > On Fri, 20 Feb 2004, Philippe Troin wrote:
> > >
> > > > The NFS client is prone to loose locks on filesystems when the locking
> > > > process is killed with a signal. This has been discussed on the nfs
> > > > mailing list in these threads:
> > > >
> > > >   http://sourceforge.net/mailarchive/forum.php?thread_id=3213117&forum_id=4930
> > > >
> > > >   http://marc.theaimsgroup.com/?l=linux-nfs&m=107074045907620&w=2
> > > >
> > > > Marcelo, if the above links are not sufficient, please email back for
> > > > more details.
> > > >
> > > > The enclosed patch is from Trond, and it fixes the problem.
> > >
> > > Hi Philippe,
> > >
> > > It might be wise to wait for the patch to be in 2.6 first?
> > >
> > > Trond, what do you think?
> >
> > I do not know about the 2.6.x status, but Trond requested help with
> > pushing this patch to the kernel, mentionning he was very busy with
> > NFSv4.
> >
> > I personnaly think it fixes a serious problem with file locking on
> > NFS, but that's my assessment.
> 
> I also think it fixes a serious problem with file locking on NFS. What I
> dont think is that it has been extensively tested (I seen you stressed
> file locking with it for a couple of days, but thats not enough).
> 
> I feel that it needs to get tested on different setups.
> 
> If Trond is confident it works reliably, I will apply it right away.

For reference and posterity, 2.4.26 includes this patch.

Thanks to Marcelo and Trond.

Phil.
