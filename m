Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbTCLPiu>; Wed, 12 Mar 2003 10:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbTCLPit>; Wed, 12 Mar 2003 10:38:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261735AbTCLPi0>; Wed, 12 Mar 2003 10:38:26 -0500
Date: Wed, 12 Mar 2003 07:47:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <20030312154311.H32093@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0303120744160.13807-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Arjan van de Ven wrote:
>
> On Wed, Mar 12, 2003 at 04:35:10PM +0100, Szakacsits Szabolcs wrote:
> > If all vendors is Red Hat then I believe you. 
> 
> I say All Vendors simply because no vendor ships 2.5 kernels yet which
> have the CONFIG option to NOT use -fomit-frame-pointer

Actually, that config option came from the 2.4.x gdb tree, since gdb users 
want to be able to see "where". So any vendor that included the remote gdb 
patch would have gotten it too.. (except in that kernel it's called 
CONFIG_REMOTE_DEBUG and brings in a lot more).

I don't know if any vendor kernels come with the kgdb patch..

		Linus

