Return-Path: <linux-kernel-owner+w=401wt.eu-S932316AbXAISDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbXAISDR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXAISDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:03:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:12957 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932316AbXAISDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:03:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Orfo7K2zD2lQqoJWlAKmkxKl8vB4AuGhyT1M7ANm1z9WcWeUjSVYqGFHvlrgFP7Hrbw1fojmVO8zQSkFwa8pbiOv7iRiATwYBfq3RutNMzkhWrgIAG9Lisy24klJW3BhbKUM0F2gzIni4Uu4tZib6xw3fdemogbnJ6m1tiPY4DM=
Message-ID: <5d96567b0701091003i6a98f8fep60d1a0b9c6c586d1@mail.gmail.com>
Date: Tue, 9 Jan 2007 20:03:15 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Erez Zadok" <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200701091728.l09HSxQI009160@agora.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070109095345.GB12406@infradead.org>
	 <200701091728.l09HSxQI009160@agora.fsl.cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/07, Erez Zadok <ezk@cs.sunysb.edu> wrote:
> In message <20070109095345.GB12406@infradead.org>, Christoph Hellwig writes:
> > On Mon, Jan 08, 2007 at 07:03:35PM -0500, Erez Zadok wrote:
> > > However, I must caution that a file system like ecryptfs is very different
> > > from Unionfs, the latter being a fan-out file system---and both have very
> > > different goals.  The common code between the two file systems, at this
> > > stage, is not much (and we've already extracted some of it into the "stackfs
> > > layer").
> >
> > I think that's an very important point.  We have a chance to get that
> > non-fanout filesystems right quite easily - something I wished that would
> > have been done before the ecryptfs merge - while getting fan-out stackable
> > filesystems is a really hard task.  In addition to that I know exactly
> > one fan-out stackable filesystem that is posisbly useful, which is unionfs.
>
> Christoph, on our Unionfs mailing list, we've been asked numerous times for
> additional functionality.  People asked for load balancing based on CPU
> time, rtt, latency, space available, etc.  People asked for replication
> functionality.  People asked for failover.  And more.  Some users have
> become so motivated, that they developed and maintain their own Unionfs
> patches to support rudimentary load-balancing and replication.
>
> Our answer had always been the same: those features are nice, but have no
> place in Unionfs.  That's why we've created RAIF, exactly to give all those

Erez hello
my name is raz.
Just for my better understanding , raifs stands for raided file system ?
what sort of raids do they have ?
thank you
raz




> who wanted "just one more thing added to Unionfs" another f/s to play with.
> Who knows, maybe one day, some of those features may wind up in a Unionfs-NG
> or as composable VFS plugins.  But for now, we've given the community RAIF
> so they can play with it, experiment, enhance, whatever.  RAIF is newer
> than Unionfs and for now we're just accumulating experience with it.
>
> In other words, I think there are other fan-out file systems of use other
> than Unionfs.  If and when Unionfs made it into mainline, I'll guarantee you
> that you'll have users asking for other fan-out functionality.  That is why I
> think it is prudent to wait and gather more experience with stackable file
> systems in Linux, before embarking on a more generic functionality layer,
> which would support non-fanout as well as fanout extensions.
>
> > Because of that I'm much more inclined to add VFS asistance for this
> > particular problem (unioning) instead of adding complex infrastructure
> > to solve a general problem that people don't benefit from.
>
> I'd love to see VFS assistance for Unioning in particular and for stacking
> in general.  But again, I prefer to gather some practical experience first,
> and then try to generalize any new VFS-level helper functionality.
>
> Sincerely,
> Erez.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Raz
