Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUDDA7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDDA7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 19:59:00 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24004 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262071AbUDDA67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 19:58:59 -0500
Date: Sat, 3 Apr 2004 19:59:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] early_param console_setup clobbers commandline
In-Reply-To: <20040403122252.5b0dba14.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404031958450.16677@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
 <20040403030537.GF31152@smtp.west.cox.net> <Pine.LNX.4.58.0404031028090.11690@montezuma.fsmlabs.com>
 <20040403201450.GG31152@smtp.west.cox.net> <20040403122252.5b0dba14.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Andrew Morton wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > > What is the patch name for Rusty's patch?
> >
> >  I don't know, since I think once he got it working he forgot to CC lkml.
> >  But I certainly hope it's in the next -mm since it replaced the
> >  parse_early_options parsing code with parse_args, so all of the stupid
> >  things my re-implementation got wrong, it doesn't.
>
> Yup, I added Rusty's patch.  It kinda wrecked everything and needs to be
> split up and sprintkled across the various earlier patches, but I haven't
> done that yet.
>
> I probably won't prepare another -mm until tomorrow though.

Do you still want the console_setup patch?
