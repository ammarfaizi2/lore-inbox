Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVJHViJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVJHViJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVJHViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:38:09 -0400
Received: from orb.pobox.com ([207.8.226.5]:54502 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932172AbVJHViH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:38:07 -0400
Date: Sat, 8 Oct 2005 16:38:04 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Justin R. Smith" <jsmith@drexel.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Instability in kernel version 2.6.12.5
Message-ID: <20051008213804.GB3577@otto>
References: <43455F33.7020102@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43455F33.7020102@drexel.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin R. Smith wrote:
> funky=
> 
> 1. the clock is frozen at about 2331 the previous night. Setting it is 
> possible, but it remains frozen at whatever time one set it to.
> 
> 2. Any X app one starts hangs.
> 
> 3. Many operations take an extraordinarily long time. Rebooting the 
> system too > 30 minutes (all spent shutting down. The restart was at the 
> normal speed).

I saw behavior quite similar to this on a P4 workstation a few months
ago -- after about 24 hours the system would get all "funky" and
/proc/interrupts showed that timer interrupts had slowed to a trickle.
Updating the BIOS fixed it.


Nathan
