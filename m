Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTJPJp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 05:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTJPJp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 05:45:58 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:49670 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262781AbTJPJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 05:45:56 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Philippe Troin <phil@fifi.org>
Subject: Re: LVM Snapshots
Date: Thu, 16 Oct 2003 11:28:23 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org,
       Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
References: <20031015174017.606c6047.Christoph.Pleger@uni-dortmund.de> <200310151751.23103.m.c.p@wolk-project.de> <87n0c2wih5.fsf@ceramic.fifi.org>
In-Reply-To: <87n0c2wih5.fsf@ceramic.fifi.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161128.23235.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 October 2003 18:53, Philippe Troin wrote:

Hi Philippe,

> Marc-Christian Petersen <m.c.p@wolk-project.de> writes:
> > On Wednesday 15 October 2003 17:40, Christoph Pleger wrote:
> >
> > Hi Christoph,
> >
> > > I am using a 2.4.22 kernel from www.kernel.org together with an XFS
> > > patch from SGI. I want to use LVM for creating snapshots for backups,
> > > but I found out that I cannot mount the snapshots of journalling
> > > filesystems (EXT3, XFS, Reiser). Only JFS snapshots can be mounted.
> > > My research on internet gave the result that a kernel-patch must be
> > > used to solve that problem, but I could not find such a patch for Linux
> > > 2.4.22, so where can I get it?
> >
> > Marcelo decided not to apply that needed patch. Here it is for you to
> > play with :) ... It'll apply with offsets to 2.4.23-pre7.
>
> What was the reason? I cannot find this thread in the archives...

it was a private mail. Pasting relevant stuff:

---------------------------------------------------------------------

Re: Patches
Date: 01.09.2003 03:42
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox 
<alan@lxorguk.ukuu.org.uk>

On Sun, 31 Aug 2003, Marc-Christian Petersen wrote:

> Hi Marcelo,
> 
> I just want to know what's wrong with these patches I've sent to you:
> 
> 
> - [PATCH 2.4.23-pre1] lowlatency fixes -12
Want to add Andreas VM stuff first.

> 
> - [PATCH 2.4.23-pre1] LVM 1.0.7 ADDON: Allow snapshots on journaling
>                                        filesystems

LVM has already been updated on 2.4.23-pre. Lets do more changes later on.

---------------------------------------------------------------------


ciao , Marc


