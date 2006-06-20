Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWFTHH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWFTHH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWFTHH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:07:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34003 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964942AbWFTHH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:07:59 -0400
Subject: Re: [patch 8/8] lock validator: add s390 to supported options
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060619150547.0b6213b1.akpm@osdl.org>
References: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com>
	 <20060619150547.0b6213b1.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 09:07:47 +0200
Message-Id: <1150787267.2891.147.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 15:05 -0700, Andrew Morton wrote:
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >
> >  config DEBUG_SPINLOCK_ALLOC
> >  	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
> > -	depends on DEBUG_SPINLOCK && X86
> > +	depends on DEBUG_SPINLOCK && (X86 || S390)
> 
> Can we please stomp this out before it starts to look like
> CONFIG_FRAME_POINTER?

why is this even an arch option ?


