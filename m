Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUL2IRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUL2IRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUL2INu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 03:13:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:36016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261444AbUL2HgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:36:01 -0500
Date: Wed, 29 Dec 2004 07:36:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jonathan Ho <jonathanho15@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel lib parser: cleaned up code and fixed redundancies
Message-ID: <20041229073600.GA10453@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jonathan Ho <jonathanho15@gmail.com>, linux-kernel@vger.kernel.org
References: <41D1FD25.3020403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D1FD25.3020403@gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -    for (p = table; !match_one(s, p->pattern, args) ; p++)
> -        ;
> +    for (p = table; !match_one(s, p->pattern, args); p++);

this is a regression in readability.  Also your patch is
whitespace-damaged.

