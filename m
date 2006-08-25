Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWHYPbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWHYPbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWHYPbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:31:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14344 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030250AbWHYPbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:31:33 -0400
Date: Fri, 25 Aug 2006 15:12:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 1/7] UBC: kconfig
Message-ID: <20060825151258.GA4145@ucw.cz>
References: <44E33893.6020700@sw.ru> <44E33B46.2010200@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33B46.2010200@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- ./kernel/ub/Kconfig.ubkm	2006-07-28 
> 13:07:38.000000000 +0400
> +++ ./kernel/ub/Kconfig	2006-07-28 
> 13:09:51.000000000 +0400
> @@ -0,0 +1,25 @@
> +#
> +# User resources part (UBC)
> +#
> +# Copyright (C) 2006 OpenVZ. SWsoft Inc

If you add copyright, add GPL, too.

> +config USER_RESOURCE
> +	bool "Enable user resource accounting"
> +	default y

New features should be disabled by default.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
