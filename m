Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTFKSsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFKSsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:48:33 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:61316
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S262403AbTFKSsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:48:32 -0400
From: "jds" <jds@soltis.cc>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem when compile 2.5.70-mm8
Date: Wed, 11 Jun 2003 12:32:55 -0600
Message-Id: <20030611182954.M88417@soltis.cc>
In-Reply-To: <200306112002.48728.schlicht@uni-mannheim.de>
References: <20030611171334.M36451@soltis.cc> <200306112002.48728.schlicht@uni-mannheim.de>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Thomas:

   Applied the patchs and my kernel is compile OK.

   Thanks....:)

   Muchas Gracias.
 

---------- Original Message -----------
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "jds" <jds@soltis.cc>, linux-kernel@vger.kernel.org
Sent: Wed, 11 Jun 2003 20:02:48 +0200
Subject: Re: problem when compile 2.5.70-mm8

> jds wrote:
> > Hi:
> >
> >    I try the compile kernel 2.5.70-mm8 and recive this messages:
>   ~~ snip ~~
> >   CC      arch/i386/kernel/setup.o
> > arch/i386/kernel/setup.c: In function `setup_early_printk':
> > arch/i386/kernel/setup.c:919: invalid lvalue in unary `&'
> > make[1]: *** [arch/i386/kernel/setup.o] Error 1
> > make: *** [arch/i386/kernel] Error 2
> >
> >   Help me please;
> >
> >   Regards.
> 
> As posted before the attached patch helps.
> 
> If you do not want to use the EARLY_PRINTK feature at all but are 
> too lazy to turn it off in the Kernel debug menu explicitly (as I am,
>  too ;-) you may also use the second attached patch wich corrects 
> dependencies in Kconf.
> 
> Best regards
>    Thomas Schlichter
------- End of Original Message -------

