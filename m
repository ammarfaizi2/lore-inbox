Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWCEIOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWCEIOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 03:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWCEIOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 03:14:07 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:48046 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751128AbWCEIOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 03:14:06 -0500
Date: Sun, 5 Mar 2006 09:14:42 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stefan Rompf <stefan@loplof.de>,
       James Ketrenos <jketreno@linux.intel.com>
Subject: Re: 2.6.16-rc5-mm2
Message-ID: <20060305081442.GH29560@ens-lyon.fr>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
>
>
> - Should be a bit better than 2.6.16-rc5-mm1, but I still had to fix a ton
>   of things to get this to compile and boot.  We're not being careful enough.
>
> - The procfs rework is getting there, but some problems probably still remain.
>
> - There will be a number of new warnings at boot time when initcalls fail.
>   Generally that's OK: it usually indicates that you linked something into
>   vmlinux which you're not actually using.  But sometimes it can indicate
>   kernel bugs.
>
> - The (much-shrunk) audit git tree is back.
>
...

>
> Changes since 2.6.16-rc5-mm1:
>
>
...
>  git-netdev-all.patch

commit 23afaec4441baf0579fa115b626242d4d23704dd
Author: Stefan Rompf <stefan@loplof.de>
Date:   Tue Feb 7 03:42:23 2006 +0800

    [PATCH] ipw2200: Fix WPA network selection problem

reverting this patch permits me to have access to the WEP network here.
Otherwise wpa_supplicant cannot establish a connection.

regards,

Benoit
