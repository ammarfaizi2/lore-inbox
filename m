Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVHSGOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVHSGOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHSGOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:14:30 -0400
Received: from [85.8.12.41] ([85.8.12.41]:19092 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932558AbVHSGO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:14:29 -0400
Message-ID: <430578C3.7020406@drzeus.cx>
Date: Fri, 19 Aug 2005 08:14:27 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk> <42D81AD7.3000407@drzeus.cx> <20050718184554.A31022@flint.arm.linux.org.uk> <42F74425.90908@drzeus.cx> <20050819000903.B11254@flint.arm.linux.org.uk>
In-Reply-To: <20050819000903.B11254@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>
>Hmm, I think I've gone back to preferring something similar to your
>original approach actually.  I've also included the IDR patch.
>
>  
>

Ok. Just as long as it works. :)

My two concerns are:

* Things that assume there's a name for every kobject.
* Things that assume that a kobject's name cannot change.

The documentation isn't clear about the semantics in these cases. But
you have more experience with kobjects than I do so perhaps these are
obvious to you.

Otherwise I'm just waiting to see this committed.

Rgds
Pierre

