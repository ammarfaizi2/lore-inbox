Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWDSPeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWDSPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWDSPeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:34:16 -0400
Received: from smtp.tele.fi ([192.89.123.25]:28143 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id S1750772AbWDSPeQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:34:16 -0400
Content-class: urn:content-classes:message
Subject: RE: searching exported symbols from modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 19 Apr 2006 18:34:12 +0300
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <963E9E15184E2648A8BBE83CF91F5FAF5154E0@titanium.secgo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjxJsrwZFHbvtiSMqM09iVqPirGwAACj8g
From: "Antti Halonen" <antti.halonen@secgo.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your persistence!

> but to what purpose?
> what on earth do you need this for?
> Again you talk about solutions not about the problem you're trying to
> solve.

I have module which has set of algorithms. When I load my module, I will
initialize my function pointer interface to point to these algorithms.
And then go ahead and use my pointers trough the application...

This way I can easily add new algorithm implementations into my product
and decide on the fly which ones to initialize into use.
 
Now. It happens that I have another module which offers algorithms I
want to be able to use. So when I shoot up my module it should be able
to initialize
either the ones the external module offers or use the internal
algorithms. In order to do this, I need to figure out on the fly if the
other module is present, where it is, where I can find the function
addresses...

Hope you can make any sense out of this!

br,
antti
 

