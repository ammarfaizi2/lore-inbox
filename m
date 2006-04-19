Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWDSQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDSQAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDSQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:00:06 -0400
Received: from smtp.tele.fi ([192.89.123.25]:31637 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id S1750782AbWDSQAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:00:03 -0400
Content-class: urn:content-classes:message
Subject: RE: searching exported symbols from modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 19 Apr 2006 18:59:59 +0300
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <963E9E15184E2648A8BBE83CF91F5FAF5154E1@titanium.secgo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjx/HpyRX/iPvIRJm68w0cTGFUVwAAa8+w
From: "Antti Halonen" <antti.halonen@secgo.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a better way would be then to have a "core" module which is basically
> collecting these algorithms, and then have the algorithm modules, when
> they are loaded, register themselves with this core module. (and
> unregister at unload). It's sort of inside-out with they way you're
> trying to do it, but it'll work out a lot nicer. Obviously the user of
> the algorithms can be another module in addition to this core module.
> (and even register algorithms itself)

Exactly, I agree 100%. But here's the catch: it's not an option at this
point in time. What I described earlier is what I currently need to do. 
