Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVF2ScA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVF2ScA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVF2ScA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:32:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262408AbVF2Sb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:31:58 -0400
Date: Wed, 29 Jun 2005 11:31:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Gernot Payer <gpayer@suse.de>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: Patch to disarm timers after an exec syscall
Message-ID: <20050629183147.GG9153@shell0.pdx.osdl.net>
References: <200506291455.45468.gpayer@suse.de> <20050629111500.61095514.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629111500.61095514.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Ouch.  What does 2.4.x do?

Does 2.4 even support realtime timers?

> It wouldn't surprise me if fixing this breaks _something_ out there.  We
> might have to remain non-POSIX-compliant for the rest of time.

But I agree, the fix is wrong as it at least breaks compliance with
itimers.

thanks,
-chris
