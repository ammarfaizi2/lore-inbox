Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269516AbUIZMJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269516AbUIZMJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUIZMJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 08:09:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:64389 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269516AbUIZMJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 08:09:56 -0400
Subject: Re: [PATCH] ppc64: Fix 32 bits conversion of SI_TIMER signals
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926094044.GB15204@suse.de>
References: <1096156004.18236.49.camel@gaston>
	 <20040926094044.GB15204@suse.de>
Content-Type: text/plain
Message-Id: <1096200493.18234.307.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 22:08:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 19:40, Olaf Hering wrote:
>  On Sun, Sep 26, Benjamin Herrenschmidt wrote:
> 
> > +		err |= __put_user((u32)(u64)s->si_ptr, &d->si_ptr);
> 
> That one surely doesnt work. Let me try it again.

Yup, my bad, see my other mail, I sent the wrong patch :(

Ben.


