Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJYJeh>; Fri, 25 Oct 2002 05:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJYJeh>; Fri, 25 Oct 2002 05:34:37 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:22791 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S261327AbSJYJeg>; Fri, 25 Oct 2002 05:34:36 -0400
Subject: Re: One for the Security Guru's
From: Henning Schmiedehausen <hps@intermeta.de>
To: Danny Lepage <danny.lepage.bur@enter-net.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1035496935.19917.106.camel@phantom.enter-net.com>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk>
	<Pine.LNX.4.44.0210241209250.648-100000@innerfire.net> 
	<ap97nr$h6e$1@forge.intermeta.de> 
	<1035496935.19917.106.camel@phantom.enter-net.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Oct 2002 11:40:45 +0200
Message-Id: <1035538846.23976.19.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 00:02, Danny Lepage wrote:
> Gee, isn't this a kind of "man in the middle" security breach ?!?! Most
> of the people on the net, including me, expect that nobody and I mean
> nobody is sitting between my browser and the web server, seeing
> unencrypted packets when we use SSL.

If you don't control the network between the Accelerator and your
webserver, you're toast anyway.

> And now your telling me that the SSL Accelerator Box and the IDS is
> seeing in clear text the traffic I thought only the web server was
> seeing ?!?! And presumably, the IDS is logging somewhere all the credit
> card info that I might be sending...

So what? How many "secure ecommerce sites" just put the information that
you sent over the secure channel into a database accessible by a tcp
port? or simply print it out? Send it via unencrypted mail to their
sales department (presumable to foobar-marketing@aol.com. Yes, I've
already seen that.). HTTPS is just a gurantee, that your data isn't
sniffed between your web browser and the device you're talking to. Once
the data hits the web server, there is nothing that HTTPS can do or you
can rely on.

> Mind you, I guess nothing prevented somebody to do something behind the
> Webserver to do some wicked thing but now, your telling me that they are
> devices, on the open market, specially design to do this!

Of course. Once you hit more than a few https transfers, you can either
burn your cpu cycles for doing crypto or simply use a device. 

	Regards
		Henning

 
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

