Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVAVQRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVAVQRE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVAVQRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:17:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64470 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262570AbVAVQRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:17:02 -0500
Date: Sat, 22 Jan 2005 16:16:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore skb_copy_datagram, removed from 2.6.11-rc2, breaking VMWare
Message-ID: <20050122161659.GA9045@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chip Salzenberg <chip@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20050122160129.GA4693@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122160129.GA4693@perlsupport.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 11:01:29AM -0500, Chip Salzenberg wrote:
> Those of you who are using VMWare 4.5 will find that 2.6.11-rc2
> removes the public function "skb_copy_datagram", breaking VMWare
> (and any other module using that interface *sigh*).
> 
> The attached patch restores the (little harmless wrapper) function.

Fix them to use the wrapped function instead.
