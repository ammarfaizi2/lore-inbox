Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSLSOO3>; Thu, 19 Dec 2002 09:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSLSOO3>; Thu, 19 Dec 2002 09:14:29 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:13799 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264686AbSLSOO3>;
	Thu, 19 Dec 2002 09:14:29 -0500
Date: Thu, 19 Dec 2002 14:22:12 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dave Jones <davej@codemonkey.org.uk>, bart@etpmod.phys.tue.nl,
       torvalds@transmeta.com, hpa@transmeta.com, terje.eggestad@scali.com,
       drepper@redhat.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219142212.GA17324@bjl1.asuk.net>
References: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl> <20021219133848.GB32524@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219133848.GB32524@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > Static binaries can just directly jump/call into the magic page.
> 
> .. and explode nicely when you try to run them on an older kernel
> without the new syscall magick. This is what Linus' first
> proof-of-concept code did.

<evil-grin>

No, because the static binary installs a SIGSEGV handler to emulate
the magic page on older kernels :)

</evil-grin>

-- Jamie
