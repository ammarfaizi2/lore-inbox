Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVDFU66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVDFU66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVDFU66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:58:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65182 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262315AbVDFU65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:58:57 -0400
Message-ID: <42544D7E.1040907@linux-m68k.org>
Date: Wed, 06 Apr 2005 22:58:38 +0200
From: Roman Zippel <zippel@linux-m68k.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       apw@shadowen.org
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory options
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
In-Reply-To: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dave Hansen wrote:

> diff -puN mm/Kconfig~A6-mm-Kconfig mm/Kconfig
> --- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-04-04 09:04:48.000000000 -0700
> +++ memhotplug-dave/mm/Kconfig	2005-04-04 10:15:23.000000000 -0700
> @@ -0,0 +1,25 @@
> +choice
> +	prompt "Memory model"
> +	default FLATMEM
> +	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
> +	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT

Does this really have to be a user visible option and can't it be
derived from other values? The help text entries are really no help at all.

bye, Roman
