Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTBKUDs>; Tue, 11 Feb 2003 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBKUDs>; Tue, 11 Feb 2003 15:03:48 -0500
Received: from [199.203.178.211] ([199.203.178.211]:4173 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S265947AbTBKUDr> convert rfc822-to-8bit; Tue, 11 Feb 2003 15:03:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Big global variables
Date: Tue, 11 Feb 2003 22:11:56 +0200
Message-ID: <AE0DC697C2336C4A9767AE031CE4B344134FC9@exchange.store-age.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Big global variables
Thread-Index: AcLSCdOpeo0/ry0VRYmoxGPDhRMLKg==
From: "Alexander Sandler" <ASandler@store-age.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

Is there a problem to define big global arrays in module (except performance issues) - big like 780Kb? I am having some weird issue here with __kmem_cache_alloc() allocating memory right in my array. It's probably some sort of memory corruption, but I want to make sure it's not something I am missing.

Thanks.

Alexandr Sandler. 
