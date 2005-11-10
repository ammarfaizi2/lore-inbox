Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVKJRLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVKJRLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKJRLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:11:10 -0500
Received: from ns.netcenter.hu ([195.228.254.57]:25303 "EHLO netcenter.hu")
	by vger.kernel.org with ESMTP id S1750976AbVKJRLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:11:08 -0500
Message-ID: <004401c5e619$3d52e1e0$ae00a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: 14-rc2 +RC4 !!! : kernel BUG at net/ipv4/tcp_output.c:438!  #2 !!!
Date: Thu, 10 Nov 2005 18:07:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert!

Sorry, but i cannot send direct mail for you. :(

Janos
----- Original Message ----- 
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Sent: Thursday, November 10, 2005 1:54 PM
Subject: Re: 14-rc2 +RC4 !!! : kernel BUG at net/ipv4/tcp_output.c:438! #2
!!!


> i have CTRL-C the cat process, and the system dies!
>
> look full.log
>
> cheers
>
>
> Doh!
> My stupid ISP is missconfig the DNS, and i cannot send you this mail
> yesterday.
>
> Janos
>
> ----- Original Message ----- 
> From: "Herbert Xu" <herbert@gondor.apana.org.au>
> To: "JaniD++" <djani22@dynamicweb.hu>
> Sent: Thursday, November 10, 2005 2:58 AM
> Subject: Re: 14-rc2 +RC4 !!! : kernel BUG at net/ipv4/tcp_output.c:438! #2
> !!!
>
>
> > On Thu, Nov 10, 2005 at 02:52:45AM +0100, JaniD++ wrote:
> > >
> > > Another info:
> > > The deadlock more often comes on slower system!
> >
> > Makes sense since that probably increases the window where the nbd
> > server can send the reply back to free the request.
> >
> > > The GNBD deadlock is VERY similar.
> > > Sample:
> > > Jul 17 23:05:10 dy-base kernel: ------------[ cut here ]------------
> > > Jul 17 23:05:10 dy-base kernel: kernel BUG at mm/highmem.c:183!
> >
> > One would presume that it's the same race condition.
> >
> > Cheers,
> > -- 
> > Visit Openswan at http://www.openswan.org/
> > Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>

