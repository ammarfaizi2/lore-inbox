Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTAOBD7>; Tue, 14 Jan 2003 20:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTAOBD7>; Tue, 14 Jan 2003 20:03:59 -0500
Received: from are.twiddle.net ([64.81.246.98]:45960 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265603AbTAOBD6>;
	Tue, 14 Jan 2003 20:03:58 -0500
Date: Tue, 14 Jan 2003 17:12:50 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling
Message-ID: <20030114171250.C5751@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030113110036.A873@twiddle.net> <20030114084011.53EA32C455@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114084011.53EA32C455@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Jan 14, 2003 at 07:39:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 07:39:44PM +1100, Rusty Russell wrote:
> After that's reverted, here's my implementation.  Richard?

Nope.  Doesn't handle undef weak.  Handling of defined weak
I'm not sure is necessary at all; I can't think of any good
use for it in the kernel.


r~
