Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWH3Tst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWH3Tst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWH3Tst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:48:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751432AbWH3Tss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:48:48 -0400
Date: Wed, 30 Aug 2006 12:47:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matt Helsley <matthltc@us.ibm.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 3/7] BC: beancounters core (API)
Message-Id: <20060830124752.8400c49e.akpm@osdl.org>
In-Reply-To: <1156964314.12403.31.camel@linuxchandra>
References: <44F45045.70402@sw.ru>
	<44F454D9.7060203@sw.ru>
	<1156964314.12403.31.camel@linuxchandra>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 11:58:34 -0700
Chandra Seetharaman <sekharan@us.ibm.com> wrote:

> > +void bc_uncharge_locked(struct beancounter *bc, int res, unsigned long val);
> > +void bc_uncharge(struct beancounter *bc, int res, unsigned long val);
> > +
> > +struct beancounter *beancounter_findcreate(bcid_t id, int mask);
> 
> prototype do not need the parameter names, types would suffice (would
> save you few characters).

argh.  Those few characters are useful.
