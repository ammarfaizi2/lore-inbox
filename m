Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbTBIEoe>; Sat, 8 Feb 2003 23:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBIEoe>; Sat, 8 Feb 2003 23:44:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28426 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267173AbTBIEod>; Sat, 8 Feb 2003 23:44:33 -0500
Date: Sat, 8 Feb 2003 20:51:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302090348.h193mcn05216@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302082049420.4686-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Roland McGrath wrote:
>
> Here is the patch vs 2.5.59-1.1007 that I am using now.  gdb seems happy.
> I have not run a lot of other tests yet.

Looks like kernel threads still go crazy at shutdown. I saw the migration 
threads apparently hogging the CPU.

		Linus

