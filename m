Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWFMUjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWFMUjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFMUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:39:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56761 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932228AbWFMUjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:39:21 -0400
Subject: Re: [patch] s390: missing ifdef in bitops.h
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <200606132233.07830.arnd@arndb.de>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
	 <1150211828.2844.20.camel@hades.cambridge.redhat.com>
	 <200606132233.07830.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 21:39:36 +0100
Message-Id: <1150231176.11159.110.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 22:33 +0200, Arnd Bergmann wrote:
> I'd suggest using only one version. In doubt, I would move the parisc
> version to asm-generic/fd_set.h or similar and include that from
> everywhere. 

That makes sense. It's not _entirely_ trivial though, so I don't want to
do it in my hdrcleanup-2.6.git tree. I'll leave it for later.

-- 
dwmw2

