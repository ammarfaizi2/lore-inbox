Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWGHOQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWGHOQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGHOQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:16:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6844 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964850AbWGHOQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:16:33 -0400
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <p73wtaonqow.fsf@verdi.suse.de>
References: <200607080124.21856.dtor@insightbb.com>
	 <p73wtaonqow.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 16:16:25 +0200
Message-Id: <1152368186.3120.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 15:58 +0200, Andi Kleen wrote:
> Dmitry Torokhov <dtor@insightbb.com> writes:
> 
> > From: Dmitry Torokhov <dtor@mail.ru>
> > 
> > Add primitives to access first and last elements of a list instead
> > of accessng pointers directly.
> 
> Wouldn't that be beter named list_first() and list_last() then?
> _get is like _do and usually not very descriptive.

and _get tends to imply a reference count as well; I'm with Andi on
this.. list_first() and list_last() 

