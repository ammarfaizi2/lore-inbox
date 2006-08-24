Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWHXNyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWHXNyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWHXNyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:54:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751548AbWHXNyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:54:12 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1156426859.3012.36.camel@pmac.infradead.org> 
References: <1156426859.3012.36.camel@pmac.infradead.org>  <1156425193.3012.32.camel@pmac.infradead.org> <32640.1156424442@warthog.cambridge.redhat.com> <778.1156426456@warthog.cambridge.redhat.com> 
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 14:54:03 +0100
Message-ID: <1312.1156427643@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> So don't put it in the header file itself. Just do 
> 
> 	#ifdef CONFIG_foo
> 	#include <linux/foo.h>
> 	#endif

That still doesn't work, but for a different reason.

> Better still, avoid the need for the external code to poke at fs-private
> header files at all.

Yeah.

David
