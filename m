Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUJXX1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUJXX1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJXX1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:27:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:64719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbUJXX1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:27:17 -0400
Date: Sun, 24 Oct 2004 16:27:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: Unwind information fix for the vsyscall DSO
In-Reply-To: <20041024230138.GA22543@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0410241626400.3016@ppc970.osdl.org>
References: <20041024230138.GA22543@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Oct 2004, Daniel Jacobowitz wrote:
>
> When working on GDB support I found a typo.  I assume the comment is
> correct.  If you step to this particular instruction and backtrace, GDB gets
> lost.
> 
> I haven't tested the fixed version yet, but I'm pretty confident in this
> patch :-)  Please apply.

The patch looks obvious, but I'd still like to see a "yeah, I tested it 
now, and yes, gdb DTRT after the fix.."

		Linus
