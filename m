Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310392AbSCGQ3R>; Thu, 7 Mar 2002 11:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310401AbSCGQ26>; Thu, 7 Mar 2002 11:28:58 -0500
Received: from h139n1fls24o900.telia.com ([213.66.143.139]:19167 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S310392AbSCGQ2x>;
	Thu, 7 Mar 2002 11:28:53 -0500
Date: Thu, 7 Mar 2002 17:29:46 +0100
From: Voluspa <voluspa@bigfoot.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
Message-Id: <20020307172946.55044bb9.voluspa@bigfoot.com>
In-Reply-To: <Pine.GSO.4.21.0203070601100.26116-100000@weyl.math.psu.edu>
In-Reply-To: <20020307114845.530abcfa.voluspa@bigfoot.com>
	<Pine.GSO.4.21.0203070601100.26116-100000@weyl.math.psu.edu>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PS. I've got a rather good grip of my Linux From Scratch system - with a BSD style init for even better control - and only load modules for one NIC and ALSA stuff here. Never have had file systems modulari(z)(s)ed DS.

On Thu, 7 Mar 2002 06:09:04 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> It boots fine from ext2 on IDE here.  Do you have any oddities in
> .config? (e.g. something silly enabled - CONFIG_PREEMPT, etc.)

Silly :-) A P166 needs every boost possible. Yes, I have preempt enabled. And yes, you are right on the mark. Compiling without preempt the booting of 2.5.6-pre3 runs flawlessly. And after a few tests no file corruption visible. But 2.5.6-pre2 + preempt-UP-bug-patch worked like a charm. So there's something else involved, it seems.

During the compilation I happened to get a brief glimpse of a warning in ide.c Don't know C so can't evaluate its severity. Went something like this: 'In function choose_drive Warning: distinkt pointer lacks a cast'.

> .config might be really useful.  Or not - it may boil down to checking

I judge it a moot point to dump all those lines now. If I'm in err, nudge me.

Thanks for the discussion.
MJ
