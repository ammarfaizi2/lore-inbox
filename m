Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTFXXde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTFXXdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:33:33 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:20361
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S263195AbTFXXdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:33:24 -0400
From: "jds" <jds@soltis.cc>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.
Date: Tue, 24 Jun 2003 17:21:56 -0600
Message-Id: <20030624231754.M61431@soltis.cc>
In-Reply-To: <3EF8CA10.4030701@aros.net>
References: <20030624191740.M38428@soltis.cc> <3EF8C9A3.5020206@aros.net> <3EF8CA10.4030701@aros.net>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi Lou, Andrew:

   Ok applied the patch Lou in kernel 2.5.73-mm1, change the .config
   CONFIG_BLK_DEV_NBD=y, compile again and kernel working good not more Oops.

   In this moment testing kernel.

   Thanks again ..... :)

   Regards.




---------- Original Message -----------
From: Lou Langholtz <ldl@aros.net>
To: jds <jds@soltis.cc>
Sent: Tue, 24 Jun 2003 16:00:48 -0600
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.

> >
> >
> >> .. . .
> >
> > I'm *guestimating* that the following patch will fix this problem. Let 
> > me know if you use it wether it makes this problem go away or not. 
> > Note that to me at least, blk_init_queue() should be responsible for 
> > initializing this memory not the driver. Either way, something has to 
> > initialize request_queue.kobj.kset otherwise I think this is the 
> > result when the kset field can be any value.
> >
> Woops... pressed send before doing the attachment...
------- End of Original Message -------

