Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWFNNEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWFNNEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFNNEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:04:36 -0400
Received: from canuck.infradead.org ([205.233.218.70]:29598 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964902AbWFNNEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:04:36 -0400
Subject: Re: [patch] s390: missing ifdef in bitops.h
From: David Woodhouse <dwmw2@infradead.org>
To: schwidefsky@de.ibm.com
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1150282204.6461.11.camel@localhost>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
	 <1150211828.2844.20.camel@hades.cambridge.redhat.com>
	 <200606132233.07830.arnd@arndb.de>  <200606132243.24584.arnd@arndb.de>
	 <1150282204.6461.11.camel@localhost>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 14:04:03 +0100
Message-Id: <1150290243.3176.112.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 12:50 +0200, Martin Schwidefsky wrote:
> Using set_bit and clear_bit is actually overkill since they use compare
> and swap to do an atomic update. That is not needed for __FD_foo. How
> about the attached patch ? 

Looks good. I'll stick that in the hdrcleanup-2.6.git tree right now, if
that's OK?

-- 
dwmw2

