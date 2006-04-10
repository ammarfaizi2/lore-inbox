Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWDJWZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWDJWZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWDJWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:25:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbWDJWZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:25:44 -0400
Date: Mon, 10 Apr 2006 14:24:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060410142458.1aec19e4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604101331030.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
	<20060409235548.52b563a9.akpm@osdl.org>
	<Pine.LNX.4.64.0604101035240.32445@scrub.home>
	<20060410005153.2a5c19e2.akpm@osdl.org>
	<Pine.LNX.4.64.0604101122530.32445@scrub.home>
	<20060410014113.5ba40dd9.akpm@osdl.org>
	<Pine.LNX.4.64.0604101331030.32445@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> > > Could you send me link or a copy of your build tools, which deals with the 
>  > > symlink?
>  > 
>  > Not sure what you mean really.  I use the normal in-tree things, plus the
>  > patch in the earlier email.
> 
>  What creates/updates the symlink

Me, typing `ln -s'.

I keep 20-odd favourite .configs under revision control and symlink to the
one I'm using.

> and what does update the file the symlink 
>  points to?

Me, using oldconfig, menuconfig, etc.  I want those changes to be made in
the symlinked-to revision-controlled config file.

