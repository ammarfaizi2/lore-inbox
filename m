Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWDEDDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWDEDDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWDEDDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:03:43 -0400
Received: from xenotime.net ([66.160.160.81]:24011 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750833AbWDEDDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:03:43 -0400
Date: Tue, 4 Apr 2006 20:05:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, ebiederm@xmission.com
Subject: Re: [PATCH] kexec: typo in machine_kexec()
Message-Id: <20060404200557.1e95bdd8.rdunlap@xenotime.net>
In-Reply-To: <20060404234806.GA25761@verge.net.au>
References: <20060404234806.GA25761@verge.net.au>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2006 08:48:08 +0900 Horms wrote:

> Signed-Off-By: Horms <horms@verge.net.au
> 
>  machine_kexec.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you use diffstat -p1 ?  does git allow/support that option, so that
more complete filenames are visible?

> b242c77f387d75d1bfa377d1870c0037d9e0c364
> diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
> index f73d737..beaad58 100644
> --- a/arch/i386/kernel/machine_kexec.c
> +++ b/arch/i386/kernel/machine_kexec.c
> @@ -194,7 +194,7 @@ NORET_TYPE void machine_kexec(struct kim
>  	 * set them to a specific selector, but this table is never
>  	 * accessed again you set the segment to a different selector.
>  	 *
> -	 * The more common model is are caches where the behide
> +	 * The more common model is are caches where the behind

Also delete /are/, but that sentence and the previous one still need some
work, so fixing "behide" isn't a big deal IMO.  However, Eric can decide
about the patch; he is the kexec maintainer.

>  	 * the scenes work is done, but is also dropped at arbitrary
>  	 * times.
>  	 *

---
~Randy
