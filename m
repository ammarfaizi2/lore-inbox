Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262559AbSI0Ris>; Fri, 27 Sep 2002 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262553AbSI0Ris>; Fri, 27 Sep 2002 13:38:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5052 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262559AbSI0Rir>;
	Fri, 27 Sep 2002 13:38:47 -0400
Date: Fri, 27 Sep 2002 19:53:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <20020927174235.GB17458@tapu.f00f.org>
Message-ID: <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Chris Wedgwood wrote:

> O_DIRECT is allow to break if someone does something silly :)  [...]

to DMA into a page that does not belong to the process anymore? I doubt
that.

	Ingo

