Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUEKOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUEKOwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbUEKOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:52:31 -0400
Received: from [62.27.20.61] ([62.27.20.61]:11417 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S264763AbUEKOw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:52:28 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] 2.6.6 add qsort library function (UPDATED PATCH, symbol exported _GPL)
Date: Tue, 11 May 2004 16:55:11 +0200
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Gruenbacher <agruen@suse.de>,
       Nathan Scott <nathans@sgi.com>
References: <20040510050733.GA13889@taniwha.stupidest.org> <20040510071552.GB30834@taniwha.stupidest.org>
In-Reply-To: <20040510071552.GB30834@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111655.11623@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Mai 2004 09:20 schrieb Chris Wedgwood:

> diff -Nru a/lib/qsort.c b/lib/qsort.c
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/lib/qsort.c	Sun May  9 20:27:15 2004
> @@ -0,0 +1,239 @@
> +/*
> + * qsort implementation for the Linux kernel.
> + *
> + * Original implementation taken form glibc and credited to Douglas
> + * C. Schmidt (schmidt@ics.uci.edu).
> + *
> + * This source code is licensed under the GNU General Public License,
> + * Version 2.  See the file COPYING for more details.
      ^^^^^^^^^


> + */
> +
> +/*
> + * If you consider tuning this algorithm, you should consult first:
> + * Engineering a sort function; Jon Bentley and M. Douglas McIlroy;
> + * Software - Practice and Experience; Vol. 23 (11), 1249-1265, 1993.
> + */
> +
> +# include <linux/module.h>
> +# include <linux/slab.h>
> +# include <linux/string.h>
> +
> +MODULE_LICENSE("GPL");

Shouldn't this be "GPLv2" then?

Eike
