Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWD1UAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWD1UAf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWD1UAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:00:35 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33227
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751808AbWD1UAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:00:34 -0400
From: Rob Landley <rob@landley.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Date: Fri, 28 Apr 2006 15:59:05 -0400
User-Agent: KMail/1.8.3
Cc: Adrian Bunk <bunk@stusta.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
References: <1145672241.16166.156.camel@shinybook.infradead.org> <200604281415.53325.rob@landley.net> <1146248859.11909.565.camel@pmac.infradead.org>
In-Reply-To: <1146248859.11909.565.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281559.05597.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 2:27 pm, David Woodhouse wrote:
> On Fri, 2006-04-28 at 14:15 -0400, Rob Landley wrote:
> > Fedora recently migrated from a linux-kernel-headers package that smells
> > a bit like Mazur's to the glibc-kernheaders package.
>
> Fedora used to be on an ancient version of the headers, forked and
> manually sanitised from 2.4 some time ago and manually (but
> inconsistently) updated to date with new syscalls &c as and when bugs
> got filed against the package.
>
> As of two days ago, Fedora is using the result of 'make headers_install'
> instead. Speaking as maintainer of Fedora's glibc-kernheaders, I think
> it's a massive improvement,
>
> Other distributions look like they should be able to change too -- the
> whole point in approaching them before implementing this was to confirm
> that they'd be happy with it. I don't know _when_ that'll happen though.
> Obviously it makes sense for them to wait while I use Fedora rawhide as
> a test bed.

I'm not waiting. :)

I'm making a cross-compiler for ARM (by hand, figuring out how to do it), and 
I have a whole weekend to thump on it.  I want to build a kernel, uClibc, and 
busybox, and get them to boot under qemu-system-arm.  That will be the "ok, 
declare victory and document what I just did" moment.

I'll let you know what breaks.  (I have Mazur's old 2.6.12 here for 
comparison, so I may even have patches.  You never know... :)

Rob
-- 
Never bet against the cheap plastic solution.
