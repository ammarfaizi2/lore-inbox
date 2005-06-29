Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVF2QaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVF2QaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVF2QaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:30:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5338 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262596AbVF2Q3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:29:46 -0400
Date: Wed, 29 Jun 2005 17:29:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christian Zankel <chris@zankel.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Xtensa syscalls (Was: Re: 2.6.12-rc5-mm1)
Message-ID: <20050629162941.GA30237@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050525134933.5c22234a.akpm@osdl.org> <200505272313.20734.arnd@arndb.de> <20050528070714.GB17005@infradead.org> <200506291542.02618.arnd@arndb.de> <42C2CAB8.1080402@zankel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C2CAB8.1080402@zankel.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 09:22:16AM -0700, Christian Zankel wrote:
> The question is, if we had to break glibc compatibility, shouldn't we 
> use the opportunity to clean-up the syscall list? It was copied from 
> MIPS and, thus, has inherited a lot of legacy from there. As a new 
> architecture, maybe we should even go as far as removing all ni-syscalls 
> and start fresh?

Yes, that should be done for a new architecture.  Unfortunately very
few people actually care.  Btw, what libcs do you have ported to xtensa?

