Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUIXTMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUIXTMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269099AbUIXTMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:12:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:21010 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269096AbUIXTMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:12:53 -0400
Date: Fri, 24 Sep 2004 20:12:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386 entry.S problems
Message-ID: <20040924201251.B30391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <s1543914.047@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s1543914.047@emea1-mh.id2.novell.com>; from JBeulich@novell.com on Fri, Sep 24, 2004 at 04:12:03PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
>  	pushl %ebp
> +#endif

CONFIG_REGPARM n eeds gcc 3.0 or later

