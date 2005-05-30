Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVE3KQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVE3KQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVE3KQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:16:56 -0400
Received: from general.keba.co.at ([193.154.24.243]:26024 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261587AbVE3KQx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:16:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: RT patch acceptance
Date: Mon, 30 May 2005 12:16:34 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323224@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT patch acceptance
Thread-Index: AcVk/Oj2jCPi82U+QiKOEKrWF6Dc/QAAD6qw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, "kus Kusche Klaus" <kus@keba.com>
Cc: "James Bruce" <bruce@andrew.cmu.edu>, "Bill Huey \(hui\)" <bhuey@lnxw.com>,
       "Andi Kleen" <ak@muc.de>,
       "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Ingo Molnar" <mingo@elte.hu>, <dwalker@mvista.com>,
       <hch@infradead.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kus Kusche Klaus wrote:
> > When I was told to analyze whether linux is suitable for our
> > needs, any nanokernel or two-OS approaches were excluded from the
> > beginning: Mgmt thought that due to their nature and complexity,
> > such approaches are not able to offer any improvements w.r.t. what 
> > we have now. Clearly, "one system and one source" is wanted!
> 
> You don't explain how making the Linux kernel hard-RT
> will be so much simpler and more supportable!

I didn't state that a hard-RT linux is simpler, technically 
(however, personally, I believe that once RT linux is there, *our*
job of writing RT applications, device drivers, ... will be simpler
compared to a nanokernel approach).

I just stated that for the management, with its limited interest and
understanding of deep technical details (and, in our case, with bad 
experiences with RT plus non-RT OS solutions), a one-system solution
*sounds* much simpler, easier to understand, and easier to manage.

Decisions in companies aren't based on purely technical facts,
sometimes not even on rational arguments...

And concerning support:

* If we go the "pure linux" way, we may (or may not) get help from
the community for our problems (it did work quite well up to now), 
or we could buy commercial linux support.

* If we go the "nanokernel plus guest linux" way, we will not get 
support from the nanokernel company for general linux kernel issues, 
the community help will also be close to zero, because we no
longer have a pure linux system, and the community is not able to
reproduce and analyze our problems any longer (in the same way lkml
is rather unable to help on vendor linux kernels or on tainted
kernels), and the same holds for most companies offering commercial
linux support.

Hence, w.r.t. support, the nanokernel approach looks much worse. 

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
