Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUIQHcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUIQHcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUIQHaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:30:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58381 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268515AbUIQH25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:28:57 -0400
Date: Fri, 17 Sep 2004 08:28:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 merge: New exports.
Message-ID: <20040917082854.E10537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1095333619.3327.189.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1095333619.3327.189.camel@laptop.cunninghams>; from ncunningham@linuxmail.org on Thu, Sep 16, 2004 at 09:20:19PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +EXPORT_SYMBOL(kd_mksound);

nope.

> +inline int buffer_busy(struct buffer_head *bh)

huh?

> -#ifdef CONFIG_COMPAT
>  EXPORT_SYMBOL(sys_ioctl);
> -#endif

No way, sorry.

> +EXPORT_SYMBOL(sys_mkdir);

Dito.  WTF are you trying to do?

> +EXPORT_SYMBOL(sys_umount);

Dito.

> +EXPORT_SYMBOL(sys_mount);

Dito.

> +EXPORT_SYMBOL(proc_match);

Gad.

> +EXPORT_SYMBOL(sys_write);

nope.  This really looks like you want to put a userland program into the
kernel.

> +EXPORT_SYMBOL(tainted);

Umm, no way again.

