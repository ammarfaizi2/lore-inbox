Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUCRMHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUCRMHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:07:23 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:64265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262574AbUCRMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:07:20 -0500
Date: Thu, 18 Mar 2004 12:07:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318120709.A27841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040318112913.GA13981@elte.hu>; from mingo@elte.hu on Thu, Mar 18, 2004 at 12:29:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:29:13PM +0100, Ingo Molnar wrote:
> or, maybe it would be better to introduce some sort of 'system
> constants' syscall that would be a generic umbrella for such things -
> and could easily be converted into a vsyscall. Or we could make it part
> of the .data section of the VDSO - thus no copying overhead, only one
> symbol lookup.

Like, umm, the long overdue sysconf()?  For the time beeing a sysctl might
be the easiest thing..

