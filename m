Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUHBMQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUHBMQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUHBMQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:16:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63160 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266495AbUHBMQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:16:38 -0400
Message-Id: <200408020320.i723KG9E007500@localhost.localdomain>
To: Jens Axboe <axboe@suse.de>
cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Sun, 01 Aug 2004 17:57:53 +0200." <20040801155753.GA13702@suse.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sun, 01 Aug 2004 23:20:16 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> said:
> On Sun, Aug 01 2004, Alexander E. Patrakov wrote:

[...]

> > Remember that it is still possible to write CDs through ide-cd in 2.4.x 
> > using some pre-alpha code in cdrecord:
> > 
> > cdrecord dev=ATAPI:1,1,0 image.iso

[...]

> Don't ever use that interface, period.

Great! So I won't be able to use any of the CD burners I have now.

>                                        It's not just the cdrecord code
> that may be alpha (I doubt it matters, it's easy to use), the interface
> it uses is not worth the lines of code it occupies.

What do you suggest then? ide-scsi is gone, so AFAIK this is the only way
to burn CDs right now on 2.6.x
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
