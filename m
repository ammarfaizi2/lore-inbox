Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQLOTTo>; Fri, 15 Dec 2000 14:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQLOTTe>; Fri, 15 Dec 2000 14:19:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29961 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129428AbQLOTTY>; Fri, 15 Dec 2000 14:19:24 -0500
Subject: Re: 2.2.18 signal.h
To: root@chaos.analogic.com
Date: Fri, 15 Dec 2000 18:50:21 +0000 (GMT)
Cc: Franz.Sirl-kernel@lauterbach.com (Franz Sirl),
        andrea@suse.de (Andrea Arcangeli), mblack@csihq.com (Mike Black),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.or)
In-Reply-To: <Pine.LNX.3.95.1001215131538.1528B-100000@chaos.analogic.com> from "Richard B. Johnson" at Dec 15, 2000 01:34:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146zw1-0001fh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	void foo()
> 	{
> 	   extern int a;
> 	   if(a) goto a;
> 	   return;
> 	   a:
> 	   printf("%d\n", a);
> 	}
> 
> 	Both examples allow an extern declaration inside a function scope
> 	which is also contrary to any (even old) 'C' standards. 'extern'
> 	is always file scope, there's no way to make it otherwise.

extern in function scope is in original C. In fact its even _older_ than that
its in the B compiler too - although in B its 'extrn' not 'extern'.

Alan (yes I programmed in B)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
