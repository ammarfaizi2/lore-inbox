Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319081AbSIJJCR>; Tue, 10 Sep 2002 05:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319082AbSIJJCQ>; Tue, 10 Sep 2002 05:02:16 -0400
Received: from mail.zmailer.org ([62.240.94.4]:6606 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S319081AbSIJJCQ>;
	Tue, 10 Sep 2002 05:02:16 -0400
Date: Tue, 10 Sep 2002 12:07:00 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK] PATCH ReiserFS 1 of 3 RESEND
Message-ID: <20020910090700.GP5834@mea-ext.zmailer.org>
References: <20020909113147.BBA73A7CDF@reload.namesys.com> <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com> <8WbPErQ1w-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8WbPErQ1w-B@khms.westfalen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 08:59:00AM +0200, Kai Henningsen wrote:
> torvalds@transmeta.com (Linus Torvalds)  wrote on 09.09.02 in <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com>:
> > where "reload.namesys.com" is not in the MX domain:
> >
> > 	dig -t MX reload.namesys.com
> ... i.e., does not have a MX record.
> > (Yes, I realize that both addresses likely work perfectly fine, and that
> 
> Since the RFCs *demand* that an address mentioned in mail has an MX  
> record, and the fallback to A records was not, until recently, described,  
> there probably are some mailers that cannot deliver mail to that address.  
> Which, in my book, counts as "not perfectly fine", even though I admit  
> those mailers are probably in a minority as, sadly, this particular  
> disease is pretty widespread.

  You haven't read your RFCs.  They demand no such thing!

  Recently the compilations of RFC 2821 and 2822 were done because there
  are about a dozen RFCs full of obscure details, and even errors.


  RFC 1123 (Requirements for Internet Hosts -- Application and Support)
  does say that the SMTP CLIENT (e.g. sending SMTP system) must support
  and use MXes.    RFC 974 says HOW:


  RFC 974 around page 4:  (Mail Routing and the Domain System)

Interpreting the List of MX RRs
  ....
   It is possible that the list of MXs in the response to the query will
   be empty.  This is a special case.  If the list is empty, mailers
   should treat it as if it contained one RR, an MX RR with a preference
   value of 0, and a host name of REMOTE.  (I.e., REMOTE is its only
   MX).  In addition, the mailer should do no further processing on the
   list, but should attempt to deliver the message to REMOTE.  The idea
   here is that if a domain fails to advertise any information about a
   particular name we will give it the benefit of the doubt and attempt
   delivery.

...
> MfG Kai

/Matti Aarnio
