Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJUUic>; Mon, 21 Oct 2002 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJUUic>; Mon, 21 Oct 2002 16:38:32 -0400
Received: from ip008.siteplanet.com.br ([200.245.54.8]:3346 "EHLO
	plutao.siteplanet.com.br") by vger.kernel.org with ESMTP
	id <S261650AbSJUUi2> convert rfc822-to-8bit; Mon, 21 Oct 2002 16:38:28 -0400
Subject: Re: [PATCH 2.0] Fixed kernel stuff
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: David Weinehall <tao@acc.umu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021015211103.GV26715@khan.acc.umu.se>
References: <1034548634.543.1.camel@nitrogenium>
	<20021014220527.GU26715@khan.acc.umu.se>
	<1034708558.427.0.camel@nitrogenium> 
	<20021015211103.GV26715@khan.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Oct 2002 17:49:04 -0200
Message-Id: <1035229745.625.0.camel@nitrogenium>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since you are doing changes to the VM, I would like detail descriptions
> of what each change does, and why it is necessary, stability- or
> security-wise. I will not accept changes to the VM subsystem unless
> there is a valid reason; let the early v2.4-series be witness to why
> this is a good stance.
David, 

I've must install Linux on AMD386 DX40, HD Maxtor 160MB, 8MB RAM for 
this task i used kernel 2.0.39. 

When I compiled kernel 2.0.39, I noticed some `warnings` which I
corrected as mentioned previously.

Then I inspected the VM subsystem code, where found any stuff 
that could be cleanup and improved, such as: 


+#define clear_page(page)       memset((void *)(page), 0, PAGE_SIZE) 
+#define copy_page(to,from)     memcpy((void *)(to), (void *)(from),
PAGE_SIZE) 


> Speedups are generally not counted as a valid reason, unless we're
> talking a change in the order of a magnitude or more. Code cleanup
> might be a good reason, but then I'll merge it into the 2.0.41-tree
> instead; this will probably be the case for your lxdialog-fixes, since
> I'm cleaning up that code anyway for 2.0.41.
LOL!
The main reason this patch is cleanup and better code standartize. 
I think thats code cleanup is good reason too!

 
> Regards: David Weinehall
> -- 
>  /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
> //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
> 

Have fun! 

-- 
Fernando Alencar Maróstica
Graduate Student, Computer Science
Linux Register User Id #281457

University Methodist of Piracicaba
Departament of Computer Science
home: http://www.unimep.br/~famarost

