Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262399AbSJISd5>; Wed, 9 Oct 2002 14:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262403AbSJISd5>; Wed, 9 Oct 2002 14:33:57 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:32526 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262399AbSJISdy>; Wed, 9 Oct 2002 14:33:54 -0400
Date: Wed, 9 Oct 2002 20:39:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Christoph Hellwig <hch@infradead.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Brendan J Simon <brendan.simon@bigpond.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
In-Reply-To: <20021009174038.A960@infradead.org>
Message-ID: <Pine.LNX.4.44.0210091859030.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, Christoph Hellwig wrote:

> Why don't you just separate the library from the kernel at all, making
> it a similar package.  We depend on a few external, kernel-specific
> packages anyway, and depending on libkconfig wouldn't make the situation
> worse.

The problem is that the config syntax will continue to evolve and
currently I prefer to keep the library close to the matching config
files.
I think I can keep the basic structure constant, but new options will be
added, so IMO it's more likely that a front end works with a newer
library than that a library can understand a newer syntax.

bye, Roman

