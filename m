Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbVIAUs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVIAUs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVIAUs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:48:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030382AbVIAUs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:48:58 -0400
Subject: Re: [syslinux] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
	limit
From: Peter Jones <pjones@redhat.com>
Reply-To: pjones@redhat.com
To: Chris Wedgwood <cw@f00f.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SYSLINUX@zytor.com
In-Reply-To: <20050831220717.GA14625@taniwha.stupidest.org>
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>
	 <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com>
	 <20050831220717.GA14625@taniwha.stupidest.org>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Thu, 01 Sep 2005 16:48:42 -0400
Message-Id: <1125607722.27195.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 (2.3.8-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 15:07 -0700, Chris Wedgwood wrote:
> On Wed, Aug 31, 2005 at 03:01:57PM -0700, H. Peter Anvin wrote:
> 
> > Maybe not.  Another option would simply be to bump it up
> > significantly (2x isn't really that much.)  4096, maybe.
> 
> I wonder if we're not at the point where we need something different
> to what we have now.  The concept of a command-line works for passing
> simple state but for more complex things it's too cumbersome.

Well, for things that don't have to be done while the kernel is loading,
it's entirely possible to do more complex things in initramfs.  Form a
second image that's got a config file in it, and make the initramfs's
init set things up based on that.

But obviously that only works for things that are tweakable from
userland.
-- 
  Peter

