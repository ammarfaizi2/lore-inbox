Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbUJ2BSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUJ2BSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUJ2AeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:34:19 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:37824 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263281AbUJ2A3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:29:03 -0400
Date: Thu, 28 Oct 2004 17:28:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH] UML: Build fix for TT w/o SKAS)
Message-ID: <20041029002831.GD12434@taniwha.stupidest.org>
References: <20041027053602.GB30735@taniwha.stupidest.org> <200410282254.21944.blaisorblade_spam@yahoo.it> <20041028214242.GB2269@taniwha.stupidest.org> <200410290149.31665.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410290149.31665.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:49:31AM +0200, Blaisorblade wrote:

> Yes, it was using SIGKILL instead of PTRACE_KILL; this gets broken
> by 2.6.9.

the problem here is that ptrace semantics are not well defined to
anything subtle can and will break from time to time

if we can get UML in a more suitable state and perhaps get some minor
QA stuff merged (a new make target using initramfs maybe?) we could
'encourage' people to test UML more often

> Well, I've seen Christoph Hellwig not particularly happy about us,
> see for instance:
>
> http://linux.bkbits.net:8080/linux-2.5/cset@41752cc9xdFXib-03VDV5akqKJZ-yA?nav=index.html|ChangeSet@-7d

well, he is right in this case

it's hard to find a balance between keeping it working for existing
UML users (which is what i'm trying to make sure is the case) and
doing cleanups which people such as hch point out really are needed

> Sending a patch requires at least proof-reading it and writing a
> meaningful changelog.  Also, managing mails takes tons of time.

im happy to take any and all fixes w/o comments in any form for now if
you want to fire them off to me
