Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTD3WqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTD3WqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:46:14 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:52141 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262482AbTD3WqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:46:12 -0400
Subject: Re: 2.5.68-mm3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030430183544.GB23891@kroah.com>
References: <20030429235959.3064d579.akpm@digeo.com>
	 <1051696273.591.4.camel@teapot.felipe-alfaro.com>
	 <20030430183544.GB23891@kroah.com>
Content-Type: text/plain
Message-Id: <1051743488.2661.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 01 May 2003 00:58:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 20:35, Greg KH wrote:
> On Wed, Apr 30, 2003 at 11:51:13AM +0200, Felipe Alfaro Solana wrote:
> > 
> > drivers/pcmcia/cs.c: In function `pcmcia_register_socket':
> > drivers/pcmcia/cs.c:361: `dev' undeclared (first use in this function)
> > drivers/pcmcia/cs.c:361: (Each undeclared identifier is reported only
> > once
> > drivers/pcmcia/cs.c:361: for each function it appears in.)
> > drivers/pcmcia/cs.c: At top level:
> > drivers/pcmcia/cs.c:391: conflicting types for
> > `pcmcia_unregister_socket'
> > drivers/pcmcia/cs.c:306: previous declaration of
> > `pcmcia_unregister_socket'
> > make[4]: *** [drivers/pcmcia/cs.o] Error 1
> > make[3]: *** [drivers/pcmcia] Error 2
> > make[2]: *** [drivers] Error 2
> > make[1]: *** [vmlinux] Error 2
> > 
> > Config file attached :-)
> 
> Does this also happen on the latest -bk tree?

Seems to be fixed in 2.5.68-bk10...
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

