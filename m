Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWDJJmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWDJJmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDJJmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:42:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751099AbWDJJmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:42:00 -0400
Date: Mon, 10 Apr 2006 01:41:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060410014113.5ba40dd9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604101122530.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
	<20060409235548.52b563a9.akpm@osdl.org>
	<Pine.LNX.4.64.0604101035240.32445@scrub.home>
	<20060410005153.2a5c19e2.akpm@osdl.org>
	<Pine.LNX.4.64.0604101122530.32445@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> On Mon, 10 Apr 2006, Andrew Morton wrote:
> 
> > > If you call "make oldconfig", you have to restore the symlink manually.
> > 
> > Why?  What advantage does that have?
> > 
> > I've been using the copy-it-there approach for maybe four years and have
> > yet to notice any problem with it.
> 
> Pretty much every other tool removes the old file before or after creating 
> the new file. This allows it to work with a hardlinked tree, which 
> unfortunately is currently broken for other reasons in kbuild.

OK.  S_ISLNK?  `setenv DONT_BE_IRRITATING 1'?

> Could you send me link or a copy of your build tools, which deals with the 
> symlink?

Not sure what you mean really.  I use the normal in-tree things, plus the
patch in the earlier email.

