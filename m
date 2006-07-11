Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWGKVD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGKVD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGKVD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:03:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65230 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932116AbWGKVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:03:58 -0400
Subject: Re: RFC: cleaning up the in-kernel headers
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <20060711173301.GA27818@infradead.org>
References: <20060711160639.GY13938@stusta.de>
	 <1152635323.3373.211.camel@pmac.infradead.org>
	 <20060711173301.GA27818@infradead.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 22:04:23 +0100
Message-Id: <1152651863.25567.71.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 18:33 +0100, Christoph Hellwig wrote:
> On Tue, Jul 11, 2006 at 05:28:43PM +0100, David Woodhouse wrote:
> > It would be nice in the general case if we could actually _compile_ each
> > header file, standalone. There may be some cases where that doesn't
> > work, but it's a useful goal in most cases, for bother exported headers
> > _and_ the in-kernel version. For the former case it would be nice to add
> > it to 'make headers_check' once it's realistic to do so.
> 
> That would be extremly valueable.  Maybe one of the kbuild gurus could
> cook up a make checkheaders rule that does this? 

We already have it for _exported_ headers -- run 'make headers_check'.
It doesn't do much yet though.

-- 
dwmw2

