Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUKWRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUKWRsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKWRrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:47:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:4766 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261389AbUKWRXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:23:11 -0500
Date: Tue, 23 Nov 2004 09:22:56 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v2][2/21] Add core InfiniBand support
Message-ID: <20041123172256.GA30264@kroah.com>
References: <20041123814.rXLIXw020elfd6Da@topspin.com> <20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:14:19AM -0800, Roland Dreier wrote:
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-bk/drivers/infiniband/core/cache.c	2004-11-23 08:10:16.816082837 -0800
> @@ -0,0 +1,338 @@
> +/*
> +  This software is available to you under a choice of one of two
> +  licenses.  You may choose to be licensed under the terms of the GNU
> +  General Public License (GPL) Version 2, available at
> +  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
> +  license, available in the LICENSE.TXT file accompanying this
> +  software.  These details are also available at
> +  <http://openib.org/license.html>.

Sorry, but this is wrong license for this file still.  Come on, you
can't tell me that your lawyers didn't vet this code at least once
before submission...

Looks like the openib group is going to have to give up on their dream
of keeping a bsd license for their code, sorry.

> +/*
> +  Local Variables:
> +  c-file-style: "linux"
> +  indent-tabs-mode: t
> +  End:
> +*/

Are these really necessary in every file?  Just set these to be your
editor's defaults.

thanks,

greg k-h
