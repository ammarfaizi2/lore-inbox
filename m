Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVD0N2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVD0N2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVD0N2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:28:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37811 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261357AbVD0N1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:27:21 -0400
Date: Wed, 27 Apr 2005 21:30:56 +0800
From: David Teigland <teigland@redhat.com>
To: Domen Puncer <domen@coderock.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050427133056.GD16502@redhat.com>
References: <20050425165826.GB11938@redhat.com> <20050427123340.GB18533@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427123340.GB18533@nd47.coderock.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 02:33:40PM +0200, Domen Puncer wrote:

> > +	if (!r->res_lvbptr)
> > +		r->res_lvbptr = allocate_lvb(r->res_ls);
> > +
> > +	memcpy(r->res_lvbptr, lkb->lkb_lvbptr, DLM_LVB_LEN);
> 
> So... can it fail?

Yes, fixed now, thanks
Dave

