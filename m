Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293285AbSCKWBC>; Mon, 11 Mar 2002 17:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293362AbSCKWAw>; Mon, 11 Mar 2002 17:00:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293285AbSCKWAq>; Mon, 11 Mar 2002 17:00:46 -0500
Date: Mon, 11 Mar 2002 17:01:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steven Cole <elenstev@mesatop.com>
cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.3.95.1020311165118.9954A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1020311165922.10077A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Richard B. Johnson wrote:

> On Mon, 11 Mar 2002, Steven Cole wrote:
> 
> > On Monday 11 March 2002 12:15 pm, Hans Reiser wrote:
> > > Steven Cole wrote:
> > > >I fiddled around a bit with VMS, and it looks like the following command
> > > > set things up for me so that I only have one version for any new files I
> > > > create:
> [SNIPPED]
> 
> > 
> > I have not figured out how to set the version_limit retroactively; perhaps
>  it is
> > not possible with a simple command.  Obviously, you could do this with a DCL 
> > script if you really wanted to.
> > 
> > Steven
> > -
> 
> $ SET PROC/PRIV=ALL
> $ SET DEF DISK:[000000]
> $ PURGE
> $ RENAME *.* ;1
> 

Oops...been a long time.... need:

$ RENAME [*...]*.* ;1

To follow the whole tree.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

