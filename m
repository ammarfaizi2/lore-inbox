Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSG3Naj>; Tue, 30 Jul 2002 09:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSG3Nai>; Tue, 30 Jul 2002 09:30:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6162 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318266AbSG3Nah>; Tue, 30 Jul 2002 09:30:37 -0400
Date: Tue, 30 Jul 2002 06:34:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Benjamin LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: async-io API registration for 2.5.29
In-Reply-To: <20020730054111.GA1159@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0207300633140.2599-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jul 2002, Andrea Arcangeli wrote:
>
> this patch against 2.5.29 adds the async-io API as from latest Ben's
> patch.

Why not make the io_submit system call number 251 like it apparently is
already in 2.4.x? We're really close to it anyway, so if you just re-order
the system calls a bit (and leave 250 as sys_ni_syscall), you're basically
there.

Other than that it looks good.

		Linus

