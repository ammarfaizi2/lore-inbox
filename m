Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUKCPUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUKCPUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUKCPUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:20:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:27570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbUKCPUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:20:02 -0500
Date: Wed, 3 Nov 2004 07:19:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: avoid asmlinkage on x86 traps/interrupts
In-Reply-To: <20041103090710.GV3571@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0411030719061.2187@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411021250310.2187@ppc970.osdl.org>
 <20041103090710.GV3571@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Nov 2004, Andrea Arcangeli wrote:
> 
> I guess it'd be nicer to simply move the output into the input with "a",
> "d", "b", and the not add any output at all, and put "eax/edx" back into
> the clobbers.

Ehh.. You aren't allowed to clobber inputs. Try it with any modern version 
of gcc.

		Linus
