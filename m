Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWFNNGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWFNNGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFNNGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:06:50 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:49564 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964901AbWFNNGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:06:49 -0400
Subject: Re: [patch] s390: missing ifdef in bitops.h
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1150290243.3176.112.camel@pmac.infradead.org>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
	 <1150211828.2844.20.camel@hades.cambridge.redhat.com>
	 <200606132233.07830.arnd@arndb.de>  <200606132243.24584.arnd@arndb.de>
	 <1150282204.6461.11.camel@localhost>
	 <1150290243.3176.112.camel@pmac.infradead.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 14 Jun 2006 15:06:50 +0200
Message-Id: <1150290410.6461.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 14:04 +0100, David Woodhouse wrote:
> On Wed, 2006-06-14 at 12:50 +0200, Martin Schwidefsky wrote:
> > Using set_bit and clear_bit is actually overkill since they use compare
> > and swap to do an atomic update. That is not needed for __FD_foo. How
> > about the attached patch ? 
> 
> Looks good. I'll stick that in the hdrcleanup-2.6.git tree right now, if
> that's OK?

Fine with me.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


