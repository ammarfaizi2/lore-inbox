Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265693AbSJXV4E>; Thu, 24 Oct 2002 17:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265694AbSJXV4E>; Thu, 24 Oct 2002 17:56:04 -0400
Received: from vulcan.cognicase.net ([64.254.0.36]:30737 "HELO
	vulcan.cognicase.net") by vger.kernel.org with SMTP
	id <S265693AbSJXV4C>; Thu, 24 Oct 2002 17:56:02 -0400
Subject: Re: One for the Security Guru's
From: Danny Lepage <danny.lepage.bur@enter-net.com>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ap97nr$h6e$1@forge.intermeta.de>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk>
	<Pine.LNX.4.44.0210241209250.648-100000@innerfire.net> 
	<ap97nr$h6e$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 18:02:10 -0400
Message-Id: <1035496935.19917.106.camel@phantom.enter-net.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gee, isn't this a kind of "man in the middle" security breach ?!?! Most
of the people on the net, including me, expect that nobody and I mean
nobody is sitting between my browser and the web server, seeing
unencrypted packets when we use SSL.

And now your telling me that the SSL Accelerator Box and the IDS is
seeing in clear text the traffic I thought only the web server was
seeing ?!?! And presumably, the IDS is logging somewhere all the credit
card info that I might be sending...

Mind you, I guess nothing prevented somebody to do something behind the
Webserver to do some wicked thing but now, your telling me that they are
devices, on the open market, specially design to do this!

So now, you have to worry about "internal" security on 3 boxes instead
of one.

Customer Information Security is now tredeoff for more Servers Security.

How sad :(

Danny

On Thu, 2002-10-24 at 12:39, Henning P. Schmiedehausen wrote:
> Nah. Do it right:
> 
> Internet ----- Firewall ---- SSL Accelerator Box --+---- Webserver
>          HTTPS          HTTPS                      | HTTP
>                                                    |
>                                                   IDS
> 
> Check out the boxes from SonicWall, they're quite nice. Expensive,
> though. If your E-Commerce site can't afford them, well, then they
> shouldn't be able to affore a security consulant in the first
> place. :-)
> 
> 	Regards
> 		Henning


