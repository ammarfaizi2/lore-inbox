Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316955AbSFFLY7>; Thu, 6 Jun 2002 07:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSFFLY6>; Thu, 6 Jun 2002 07:24:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21495 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316955AbSFFLY5>; Thu, 6 Jun 2002 07:24:57 -0400
Subject: Re: [PATCH] 2.4.19pre9 in pdc202xx.c bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hank Yang <hanky@promise.com.tw>
Cc: andre@serialata.org, marcelo@conectiva.com,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        arjanv@redhat.com, Linus Chen <linusc@promise.com.tw>,
        jordanr@promise.com
In-Reply-To: <004501c20d02$4ac734a0$c0cca8c0@promise.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 13:17:21 +0100
Message-Id: <1023365841.22186.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.18 driver you sent me is not going to match the 2.4.19pre code
because there are other changes to get LBA48 generally available and
clean up problems in the codebase.

I'd love to have Promise the active maintainers of the promise IDE code.
That does mean someone at promise fixing (or checking) any IDE changes
that need to occur to the Promise IDE driver. 

If you want to set things up that way then

-	Send me a patch to get 2.4.19pre10 merged with the changes you want
for the chipset tuning etc
-	Send me an entry for the MAINTAINERS file.
-	Add a note to the top of pdc202xx indicating all changes should be
sent to you for review.

That should ensure things get routed the right way.

Alan

