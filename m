Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUGRWTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUGRWTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUGRWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:19:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32174 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264550AbUGRWTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:19:10 -0400
Date: Mon, 19 Jul 2004 00:19:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [14/25] Merge pmdisk and swsusp
Message-ID: <20040718221909.GF31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/**
> + *	write_header - Fill and write the suspend header.
> + *	@entry:	Location of the last swap entry used.
> + *
> + *	Allocate a page, fill header, write header.
> + *
> + *	@entry is the location of the last pagedir entry written on
> + *	entrance. On exit, it contains the location of the header.
> + */
> +
> +int swsusp_write_header(swp_entry_t * entry)
> +{
> +	return swsusp_write_page((unsigned long)&swsusp_info,entry);
> +}

I do not think this function matches its documentation.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
