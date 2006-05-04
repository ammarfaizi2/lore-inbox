Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWEDCD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWEDCD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 22:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWEDCD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 22:03:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:39149 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750852AbWEDCD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 22:03:29 -0400
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific
	files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <904F5BD9-1ACB-4936-B390-E4128886824C@kernel.crashing.org>
References: <20060429232812.825714000@localhost.localdomain>
	 <200605020150.14152.arnd@arndb.de>
	 <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
	 <200605021259.24157.arnd@arndb.de>
	 <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
	 <17496.6519.733076.663815@cargo.ozlabs.ibm.com>
	 <904F5BD9-1ACB-4936-B390-E4128886824C@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 04 May 2006 12:03:05 +1000
Message-Id: <1146708185.6652.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, what was I thinking.  So use some platform hook instead.

You must be smoking good stuff :)

> But Arnd of course is right; if the driver (currently) only works
> on a certain platform, just mark it as such in the Makefile (erm,
> Kconfig file).

Exactly :) I don't see any point in adding hooks or ifdef's or anything
fancy like that to guard from something that doesn't exist in real life:
that is building that driver on non-cell :) Thus Kconfig is the way to
go.


