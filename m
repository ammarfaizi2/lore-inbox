Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUEBAEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUEBAEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUEBAEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:04:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:47804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262766AbUEBAEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:04:23 -0400
Date: Sat, 1 May 2004 17:03:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@osdl.org, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-Id: <20040501170338.1934beb5.akpm@osdl.org>
In-Reply-To: <20040502000046.GA24649@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040502000046.GA24649@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Sat, May 01, 2004 at 04:55:30PM -0700, Linus Torvalds wrote:
> 
> > Yes. Except we should probably only do this for __KERNEL_SYSCALLS__,
> > since it's possible that somebody is still using this in user space
> > (it pre-glibc people).
> 
> I'm confused.
> 
> I thought it has been decreed using kernel headers in userspace was a
> bad idea (DONT DO THAT) so in theory we can just ignore this issue?
> 

I prefer not to break stuff which people are currently using, particularly
when avoiding the breakage is a simple thing.
