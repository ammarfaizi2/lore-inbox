Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbUAIUl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUAIUl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:41:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:21771 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264487AbUAIUl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:41:56 -0500
Date: Fri, 9 Jan 2004 20:41:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity checking
Message-ID: <20040109204150.A28436@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Maciej Zenczykowski <maze@cela.pl>, Jesper Juhl <juhl-lkml@dif.dk>,
	Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0401090437060.11276@jju_lnx.backbone.dif.dk> <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>; from maze@cela.pl on Fri, Jan 09, 2004 at 09:20:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 09:20:53PM +0100, Maciej Zenczykowski wrote:
> I think this points to an 'issue', if we're going to increase the checks
> in the ELF-loader (and thus increase the size of the minimal valid ELF
> file we can load, thus effectively 'bloating' (lol) some programs) we
> should probably allow some sort of direct binary executable files [i.e.
> header 'XBIN386\0' followed by Read/Execute binary code to execute by

Like binfmt_flat? :)

