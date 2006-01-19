Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWASKIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWASKIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWASKIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:08:23 -0500
Received: from general.keba.co.at ([193.154.24.243]:41859 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1161080AbWASKIW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:08:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: My vote against eepro* removal
Date: Thu, 19 Jan 2006 11:08:17 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323321@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYcy9rqb/G5qZO0RDe1/KEdpPhhOwAE7mPA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arjan van de Ven
> On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> > Last time I tested (around 2.6.12), eepro100 worked much better 
> > in -rt kernels w.r.t. latencies than e100:
> 
> no offence but this is EXACTLY the reason why having 2 drivers for the
> same hardware is bad. People (in general) will switch to the 
> 2nd driver
> if they hit some thing that is suboptimal, rather than 
> reporting or even
> fixing it. The result of that is that you end up with 2 drivers, each
> serving a portion of the users but both suboptimal in non-overlapping
> ways. Having one driver that's good enough for both groups is clearly
> superior to that....

You describe exactly what happened: I had a problem with e100, I tried
eepro100, I was happy with eepro100 (I didn't notice it was scheduled
for removal), I didn't care about e100 any more...

I also agree that things should not happen that way, but it was the
easy way.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
 
