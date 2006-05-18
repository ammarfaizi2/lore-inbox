Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWERKH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWERKH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 06:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWERKH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 06:07:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751334AbWERKH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 06:07:26 -0400
Date: Thu, 18 May 2006 03:07:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: michael@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
Message-Id: <20060518030719.14995317.akpm@osdl.org>
In-Reply-To: <1147946150.7360.29.camel@localhost.localdomain>
References: <20060518091410.CC527679F4@ozlabs.org>
	<20060518023449.4e697b96.akpm@osdl.org>
	<1147946150.7360.29.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <michael@ellerman.id.au> wrote:
>
>  I'll trawl through the console drivers tomorrow and see if I can guess
>  what percentage look like they will/won't work, then we can decide which
>  way to flip it.

Yes, that's probably safer and saner, thanks.  Don't bust a gut over
it though - it's not your problem and if someone's hurting from it
then they can write and test the patch.

I guess many people are using earlyprintk or console=uart..
