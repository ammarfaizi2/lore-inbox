Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUBDXyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUBDXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:54:39 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:54423 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S265083AbUBDXwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:52:16 -0500
Date: Wed, 4 Feb 2004 16:52:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040204235215.GA1086@smtp.west.cox.net>
References: <20040204230133.GA8702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204230133.GA8702@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 12:01:33AM +0100, Pavel Machek wrote:

> Hi!
> 
> It seems that some kgdb support is in 2.6.2-linus:
> 
> +++ b/Documentation/sh/kgdb.txt Tue Feb  3 19:45:43 2004
> @@ -0,0 +1,179 @@
> +
> +This file describes the configuration and behavior of KGDB for the SH
> +kernel. Based on a description from Henry Bell <henry.bell@st.com>, it
> +has been modified to account for quirks in the current implementation.
> +
> 
> That's great, can we get i386 kgdb, too? Or at least amd64 kgdb
> ;-). [Or was it a mistake? It seems unlikely that kgdb could enter
> Linus tree without major flamewar...]

FWIW, there has been PPC32 KGDB support in kernel.org for ages.  OTOH,
I'm quite happy that SH kgdb support came in (mental note made to talk
to Henry about the KGDB merging stuffs).

-- 
Tom Rini
http://gate.crashing.org/~trini/
