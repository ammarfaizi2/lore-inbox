Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274815AbTGaQoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274817AbTGaQod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:44:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:47802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274815AbTGaQo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:44:29 -0400
Date: Thu, 31 Jul 2003 09:45:21 -0700
From: Dave Olien <dmo@osdl.org>
To: Bernd Eckenfels <ecki-lmk@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse function pointer arguments now accept void pointers
Message-ID: <20030731164521.GA3796@osdl.org>
References: <20030731052810.GA2853@osdl.org> <E19i6wG-0000Um-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19i6wG-0000Um-00@calista.inka.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bernd,

I might have messed up here.  But could you give a little more explanation,
to help me understand what you think is wrong with this and why?

Dave

On Thu, Jul 31, 2003 at 08:29:24AM +0200, Bernd Eckenfels wrote:
> In article <20030731052810.GA2853@osdl.org> you wrote:
> > This patch eliminates warnings of the form:
> ...
> > -       if (t->type == SYM_PTR) {
> > +       if (t->type == SYM_PTR || t->type == SYM_FN) {
> 
> unlikely
> 
> Greetings
> Bernd
> -- 
> eckes privat - http://www.eckes.org/
> Project Freefire - http://www.freefire.org/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
