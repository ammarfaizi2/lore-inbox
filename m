Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUBERJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUBERJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:09:22 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:38343 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S266334AbUBERJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:09:19 -0500
Date: Thu, 5 Feb 2004 18:09:10 +0100 (MET)
Message-Id: <200402051709.i15H9AF28042@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: Pat LaVarre <p.lavarre@ieee.org>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <1075996629.6941.10.camel@patibmrh9> (message from Pat LaVarre on
	     05 Feb 2004 08:57:09 -0700)
Subject: Re: [ANNOUNCE] Filesystem in Userspace (FUSE) 1.1 stable version
References: <200402051258.i15Cw2E20493@kempelen.iit.bme.hu> <1075996629.6941.10.camel@patibmrh9>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > FUSE is a combination of a kernel module and a
> > userspace library that makes the creation of
> > filesystems in userspace very easy.
> 
> Any connection here with making linux fs easier to learn?

Not really.  FUSE and the linux VFS have not much in common except they
both have a similar set of operations (open, read, write, mkdir,
unlink, etc.).  But linux VFS is much more generic.

> I ask because I've not found any reasonably quick way of making sense
> of:
> 
> http://lxr.linux.no/source/fs/udf/

Yeah, a working UDF implementation would be good.  It's very easy to
prototype such an FS in FUSE.  Any takers? ;)

> Thank you from that I found:
> 
> the AVFS project page on sourceforge
> http://sourceforge.net/projects/avf/

The homepage and SF project page of AVFS and FUSE are a mess.  Sorry
about that.

> Also I see this FUSE is not sourceforge.net/projects/fuse/.

That is true.  the name FUSE turned out to be unfortunate, because
it's an often chosen project name.

Miklos
