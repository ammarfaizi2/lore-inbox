Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbTAEGzl>; Sun, 5 Jan 2003 01:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTAEGzk>; Sun, 5 Jan 2003 01:55:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46399 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263362AbTAEGzk>; Sun, 5 Jan 2003 01:55:40 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make ide-probe more robust to non-ready devices
References: <1041672876.1346.23.camel@zion.wanadoo.fr>
	<1041713307.2036.10.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jan 2003 00:03:02 -0700
In-Reply-To: <1041713307.2036.10.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1adigjcyh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sat, 2003-01-04 at 09:34, Benjamin Herrenschmidt wrote:
> > I don't expect this patch to break any existing working configuration,
> > so please send to Linus for 2.5. If you accept it, I'll then send a 2.4
> > version to Marcelo as well. This have been around for some time and,
> > imho, should really get in now.
> 
> There is a ton of stuff pending for 2.5 IDE. Unfortunately 2.5 isn't in
> a state I can do any usable testing so it will have to wait. The Marcelo
> 2.4 tree is current and I'm doing the work in 2.4 first now.
> 
> Rusty seems to have a lot of the module stuff in hand so hopefully I'll
> get back onto 2.5 after LCA

Whatever the kernel is let me send a hearty me to on this one.  I have
been doing something similar without problems.

I have heard reports that there are some drive/controller combinations
that polling the BSY bit does not work on to get them past the initial
drive spin up state.  However waiting for BSY to clear is no worse
than anything else on those setups, and this works for quite a few.

Eric
