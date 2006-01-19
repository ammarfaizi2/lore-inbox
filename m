Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWASR7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWASR7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWASR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:59:18 -0500
Received: from rialto-h50.host.net ([64.135.31.50]:62087 "EHLO
	mail.ultrawaves.com") by vger.kernel.org with ESMTP
	id S1161043AbWASR7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:59:18 -0500
Message-ID: <43CFD364.3010803@lammerts.org>
Date: Thu, 19 Jan 2006 12:59:00 -0500
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> +config CC_OPTIMIZE_FOR_SIZE
> +	bool "Optimize for size (Look out for broken compilers!)"
> +	default y
> +	depends on ARM || H8300 || EXPERIMENTAL
> +	depends on !SPARC64
> +	help
> +	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> +	  resulting in a smaller kernel.
> +
> +	  WARNING: some versions of gcc may generate incorrect code with this
> +	  option.  If problems are observed, a gcc upgrade may be needed.
> +
> +	  If unsure, say N.

"default y" and "If unsure, say N" ?

If not sure, don't go with the default?

Eric
