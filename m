Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWABOz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWABOz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWABOz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:55:57 -0500
Received: from general.keba.co.at ([193.154.24.243]:21625 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750714AbWABOz4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:55:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Mon, 2 Jan 2006 15:55:52 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323310@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYPqv7J65v/H/e8Q16WbYfW4nzTDgAAKgXw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> Right .. I'm still looking into it. ARM is just missing some vital
> tracing bits I think .

As I wrote in some earlier mail, I'm probably the first one ever
who tried it on ARM: When I tried first, tracing didn't work at all,
because the trace timing macro's were not defined (at least for
sa1100). I quick-hacked the three missing macros (this caused the
tracer to produce at least some output) without checking if 
anything else is missing.


-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
