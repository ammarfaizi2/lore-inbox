Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265555AbSJXQ6m>; Thu, 24 Oct 2002 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265556AbSJXQ6m>; Thu, 24 Oct 2002 12:58:42 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:18600 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265555AbSJXQ6i>; Thu, 24 Oct 2002 12:58:38 -0400
Subject: Re: One for the Security Guru's
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ap97nr$h6e$1@forge.intermeta.de>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk>
	<Pine.LNX.4.44.0210241209250.648-100000@innerfire.net> 
	<ap97nr$h6e$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 19:04:46 +0200
Message-Id: <1035479086.9935.6.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 18:39, Henning P. Schmiedehausen wrote:
> Gerhard Mack <gmack@innerfire.net> writes: 
> >It gets even worse if almost all of your services are encrypted(like you
> >would find on an e-commerse site).  https will blind an IDS.  The last
> >place I worked only had 3 ports open and 2 of them were encrypted.
> 
> Nah. Do it right:
> 
> Internet ----- Firewall ---- SSL Accelerator Box --+---- Webserver
>          HTTPS          HTTPS                      | HTTP
>                                                    |
>                                                   IDS
> 

Eh... not really:

A. If there's a buffer overflow in the SSL Accelerator box the firewall
wont do you much good (it helps, but only a little). 

B. The firewall in this setup provides very little besides packet
filtering anyway.

SO... basically we're back to square one. A better firewall might offer
more features but in the end the end point must be secure or all of
these features wont do a damn good, thus in many cases it would make
sense to use the free (as in both beer and speech) solution provided by
Linux, not because it's the best, but because it's enough: there are
weaker links to worry about.

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

 "Geeks rock bands cool name #8192: RAID against the machine"

