Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWIDO6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWIDO6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWIDO6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:58:36 -0400
Received: from mail.suse.de ([195.135.220.2]:6793 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751080AbWIDO6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:58:35 -0400
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Andrew Morton <akpm@osdl.org>, Grant Coady <gcoady.lk@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH-mm] i8042: activate panic blink only in X
References: <200609022320.36754.dtor@insightbb.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Sep 2006 16:58:33 +0200
In-Reply-To: <200609022320.36754.dtor@insightbb.com>
Message-ID: <p738xkz65ly.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor@insightbb.com> writes:

> Hi,
> 
> Here is an attempt to make panicblink only active in X so there is a
> chance of keyboard still working after panic in text console. Any reason
> why is should not be done this way?
> 

Looks good to me.

Of course it would be even better to fix the panic stuff to not disrupt scrollback,
but short of that it's a good idea.

-Andi (original panic blink author)
