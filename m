Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbTLWLQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTLWLQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:16:56 -0500
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:12296 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S265048AbTLWLQy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:16:54 -0500
Subject: Re: SCO's infringing files list
From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0312222353310.27724@jju_lnx.backbone.dif.dk>
References: <1072125736.1286.170.camel@duergar>
	 <Pine.LNX.4.56.0312222353310.27724@jju_lnx.backbone.dif.dk>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1072178288.8753.7.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 23 Dec 2003 09:18:08 -0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jesper,

Em Seg, 2003-12-22 às 21:01, Jesper Juhl escreveu:
> One thing I noticed.
> 
> I'm looking at include/signal.h from linux-0.01 and the definition of the
> signal() function, the prototype in include/signal.h is
> 
> void (*signal(int _sig, void (*_func)(int)))(int);
>
> I then take a look in my copy of UNIX Network Programming by W. Richard
> Stevens from 1990, and notice that he on page 46 says this :
> 
> "...
> A process specifies how it wants a signal handled by calling the signal
> system call.
> 
> #include <signal.h>
> 
> int (*signal (int sig, void (*func)(int)))(int);
> 
> ..."
> 
> 
> The return type here is "int" while Linus originally made the return type
> "void". If Linus had copied signal.h from UNIX the return type would have
> been "int"...

 Seems to me the Linus version comes from Minix. Its return type is
void too:

http://www.minix-vmd.org/source/std/1.5/include/signal.h

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

