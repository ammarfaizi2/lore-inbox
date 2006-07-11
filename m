Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWGKRdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWGKRdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWGKRdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:33:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11246 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751138AbWGKRdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:33:04 -0400
Date: Tue, 11 Jul 2006 18:33:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711173301.GA27818@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152635323.3373.211.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:28:43PM +0100, David Woodhouse wrote:
> It would be nice in the general case if we could actually _compile_ each
> header file, standalone. There may be some cases where that doesn't
> work, but it's a useful goal in most cases, for bother exported headers
> _and_ the in-kernel version. For the former case it would be nice to add
> it to 'make headers_check' once it's realistic to do so.

That would be extremly valueable.  Maybe one of the kbuild gurus could
cook up a make checkheaders rule that does this?

