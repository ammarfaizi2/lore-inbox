Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293540AbSCKWWm>; Mon, 11 Mar 2002 17:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293538AbSCKWWd>; Mon, 11 Mar 2002 17:22:33 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:48307 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293533AbSCKWWT>; Mon, 11 Mar 2002 17:22:19 -0500
Message-Id: <200203112134.OAA12196@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: root@chaos.analogic.com, Steven Cole <elenstev@mesatop.com>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Mon, 11 Mar 2002 15:19:52 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020311165118.9954A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020311165118.9954A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 02:54 pm, Richard B. Johnson wrote:
> On Mon, 11 Mar 2002, Steven Cole wrote:
> > On Monday 11 March 2002 12:15 pm, Hans Reiser wrote:
> > > Steven Cole wrote:
> > > >I fiddled around a bit with VMS, and it looks like the following
> > > > command set things up for me so that I only have one version for any
> > > > new files I create:
>
> [SNIPPED]
>
> > I have not figured out how to set the version_limit retroactively;
> > perhaps
>
>  it is
>
> > not possible with a simple command.  Obviously, you could do this with a
> > DCL script if you really wanted to.
> >
> > Steven
> > -
>
> $ SET PROC/PRIV=ALL
> $ SET DEF DISK:[000000]
> $ PURGE
> $ RENAME *.* ;1
>
>
> Cheers,
> Dick Johnson

Sure, that cleans up everything and sets all the version numbers back to ;1, 
but what I was pointing out is that previously created directories and previously
created files retain whatever version_limit setting they were created with.  After
running your four lines, the disk is cleaner, but you'll still get multiple versions
even if you don't want multiple versions for those previously created directories
and files.  I know, I just tried it with VMS 5.5-2. But this is all rather moot, 
since the real topic at hand is not what VMS does or didn't do in the past, but rather 
what we _might_ want certain linux filesystems to do (and not do) in the future.

Steven
