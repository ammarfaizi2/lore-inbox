Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSJYJhx>; Fri, 25 Oct 2002 05:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSJYJhx>; Fri, 25 Oct 2002 05:37:53 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:37639 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S261329AbSJYJhv>; Fri, 25 Oct 2002 05:37:51 -0400
Subject: Re: One for the Security Guru's
From: Henning Schmiedehausen <hps@intermeta.de>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1035479086.9935.6.camel@gby.benyossef.com>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk>
	<Pine.LNX.4.44.0210241209250.648-100000@innerfire.net> 
	<ap97nr$h6e$1@forge.intermeta.de> 
	<1035479086.9935.6.camel@gby.benyossef.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Oct 2002 11:44:02 +0200
Message-Id: <1035539042.23977.24.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 19:04, Gilad Ben-Yossef wrote:
> On Thu, 2002-10-24 at 18:39, Henning P. Schmiedehausen wrote:
> > Gerhard Mack <gmack@innerfire.net> writes: 
> > >It gets even worse if almost all of your services are encrypted(like you
> > >would find on an e-commerse site).  https will blind an IDS.  The last
> > >place I worked only had 3 ports open and 2 of them were encrypted.
> > 
> > Nah. Do it right:
> > 
> > Internet ----- Firewall ---- SSL Accelerator Box --+---- Webserver
> >          HTTPS          HTTPS                      | HTTP
> >                                                    |
> >                                                   IDS
> > 
> 
> Eh... not really:
> 
> A. If there's a buffer overflow in the SSL Accelerator box the firewall
> wont do you much good (it helps, but only a little). 

This is a hardware device. Hardware as in "silicon". I very much doubt
that you can run "general purpose programs" on a device specifically
designed to do crypto. And this is _not_ just an "embedded Linux on ix86
with a crypto chip". 

> B. The firewall in this setup provides very little besides packet
> filtering anyway.

You're right. But if I'd let it off, I'd would have gotten mail with
"there is no firewall in your setup, it's not secure". Either way I
lose. :-)

	Regards
		Henning

 
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

