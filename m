Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTD3SVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTD3SVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:21:39 -0400
Received: from granite.he.net ([216.218.226.66]:14607 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262285AbTD3SVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:21:38 -0400
Date: Wed, 30 Apr 2003 11:35:44 -0700
From: Greg KH <greg@kroah.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm3
Message-ID: <20030430183544.GB23891@kroah.com>
References: <20030429235959.3064d579.akpm@digeo.com> <1051696273.591.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051696273.591.4.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:51:13AM +0200, Felipe Alfaro Solana wrote:
> 
> drivers/pcmcia/cs.c: In function `pcmcia_register_socket':
> drivers/pcmcia/cs.c:361: `dev' undeclared (first use in this function)
> drivers/pcmcia/cs.c:361: (Each undeclared identifier is reported only
> once
> drivers/pcmcia/cs.c:361: for each function it appears in.)
> drivers/pcmcia/cs.c: At top level:
> drivers/pcmcia/cs.c:391: conflicting types for
> `pcmcia_unregister_socket'
> drivers/pcmcia/cs.c:306: previous declaration of
> `pcmcia_unregister_socket'
> make[4]: *** [drivers/pcmcia/cs.o] Error 1
> make[3]: *** [drivers/pcmcia] Error 2
> make[2]: *** [drivers] Error 2
> make[1]: *** [vmlinux] Error 2
> 
> Config file attached :-)

Does this also happen on the latest -bk tree?

thanks,

greg k-h
