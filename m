Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289965AbSAPDmB>; Tue, 15 Jan 2002 22:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289955AbSAPDlx>; Tue, 15 Jan 2002 22:41:53 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:7103 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290341AbSAPDli>; Tue, 15 Jan 2002 22:41:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Nicolas Pitre <nico@cam.org>, "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: CML2-2.1.3 is available
Date: Tue, 15 Jan 2002 14:19:07 -0500
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0201151538340.5892-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.33.0201151538340.5892-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116034137.CRFB26021.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 03:41 pm, Nicolas Pitre wrote:
> On Tue, 15 Jan 2002, Eric S. Raymond wrote:
> > Nicolas Pitre <nico@cam.org>:
> > > > Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> > > > 	* The `vitality' flag is gone from the language.  Instead, the
> > > > 	  autoprober detects the type of your root filesystem and forces
> > > > 	  its symbol to Y.
> > >
> > > What happens if you compile a kernel for another machine?  Or
> > > cross-compile?
> >
> > In that case you can't use the autoconfigurator anyway.
>
> Sorry.  I passed over "autoprober" too fast.  As long as auto* stuff can
> be turned off that fine.

It's optional.

I -STILL- can't figure out why the autoprober doesn't just look in 
/proc/mounts to figure out who and what our root device and filesystem are.

I need to set up a system that boots to an initrd and puts the root device 
lives on a samba server just to confuse eric's autoprober.  Hmmm...  I wonder 
if that would work? :)

Rob

