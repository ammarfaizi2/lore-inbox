Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSEFKVi>; Mon, 6 May 2002 06:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314380AbSEFKVh>; Mon, 6 May 2002 06:21:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14960 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314379AbSEFKVg>; Mon, 6 May 2002 06:21:36 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot params 1/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<20020427025642.E413@toy.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2002 04:13:34 -0600
Message-ID: <m1u1pl1t4h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > #5  boot.heap
> > ============================================================
> > Modify video.S so that mode_list is also allocated from
> > the boot time heap.  This probably saves a little memory,
> > and makes a compiled in command line a sane thing to implement.
> 
> Do you see easy way to pass video mode used to kernel? S3 suspend support
> is going to need that..

Do you mean something other than the vga= command line option?
Which actually just sets a 16bit mode in the kernel parameter structure.

Eric
