Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFARZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFARZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFARZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:25:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:30623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbVFARZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:25:21 -0400
Date: Wed, 1 Jun 2005 10:25:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] Sample fix for hyperthread exploit
Message-ID: <20050601172505.GM23013@shell0.pdx.osdl.net>
References: <200506012158.39805.kernel@kolivas.org> <1117627597.6271.29.camel@laptopd505.fenrus.org> <200506012213.25445.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506012213.25445.kernel@kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas (kernel@kolivas.org) wrote:
> On Wed, 1 Jun 2005 22:06, Arjan van de Ven wrote:
> > > Comments?
> >
> > I don't think it's really worth it, but if you go this way I'd rather do
> > this via a prctl() so that apps can tell the kernel "I'd like to run
> > exclusive on a core". That'd be much better than blindly isolating all
> > applications.
> 
> I agree, and this is where we (could) implement the core isolation. I'm still 
> under the impression (as you appear to be) that this theoretical exploit is 
> not worth trying to work around.

Also, uid is not sufficient.  Something more comprehensive (like ability
to ptrace) would be appropriate.

thanks,
-chris
