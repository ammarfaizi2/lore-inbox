Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbRESWUk>; Sat, 19 May 2001 18:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbRESWUb>; Sat, 19 May 2001 18:20:31 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:45837 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261802AbRESWUX>; Sat, 19 May 2001 18:20:23 -0400
Date: Sat, 19 May 2001 23:20:20 +0100 (BST)
From: John Levon <moz@compsoc.man.ac.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Brown-paper-bag bug in m68k, sparc, and sparc64
 config files
In-Reply-To: <20010519181026.A23730@thyrsus.com>
Message-ID: <Pine.LNX.4.21.0105192318470.10339-100000@mrbusy.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Eric S. Raymond wrote:

> This bug unconditionally disables a configuration question -- and it's
> so old that it has propagated across three port files, without either
> of the people who did the cut and paste for the latter two noticing it.

in fact it was originally in i386 too. I noticed and fixed it,
didn't even think about the other archs.

> This sort of thing would never ship in CML2, because the compiler
> would throw an undefined-symbol warning on BLK_DEV_ST.  The temptation
> to engage in sarcastic commentary at the expense of people who still
> think CML2 is an unnecessary pain in the butt is great.  But I will

Most of these people don't seem to have been subscribed to kbuild-devel
anyway, and missed most of the commentary over the past months.

> -   if [ "$CONFIG_BLK_DEV_ST" != "n" ]; then
> +   if [ "$CONFIG_CHR_DEV_ST" != "n" ]; then

john

-- 
"A reasonable probability is the only certainty."
	- E. W. Howe

