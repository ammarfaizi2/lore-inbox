Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUDCUXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUDCUXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:23:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:64469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbUDCUXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:23:02 -0500
Date: Sat, 3 Apr 2004 12:22:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] early_param console_setup clobbers commandline
Message-Id: <20040403122252.5b0dba14.akpm@osdl.org>
In-Reply-To: <20040403201450.GG31152@smtp.west.cox.net>
References: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
	<20040403030537.GF31152@smtp.west.cox.net>
	<Pine.LNX.4.58.0404031028090.11690@montezuma.fsmlabs.com>
	<20040403201450.GG31152@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> > What is the patch name for Rusty's patch?
> 
>  I don't know, since I think once he got it working he forgot to CC lkml.
>  But I certainly hope it's in the next -mm since it replaced the
>  parse_early_options parsing code with parse_args, so all of the stupid
>  things my re-implementation got wrong, it doesn't.

Yup, I added Rusty's patch.  It kinda wrecked everything and needs to be
split up and sprintkled across the various earlier patches, but I haven't
done that yet.

I probably won't prepare another -mm until tomorrow though.
