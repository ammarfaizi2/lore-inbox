Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275330AbTHGN4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275331AbTHGN4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:56:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:23427 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275330AbTHGNzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:55:48 -0400
Subject: Re: 2.6.0-test2: unable to suspend (APM)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Charles Lepple <clepple@ghz.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807120056.B17690@flint.arm.linux.org.uk>
References: <20030806231519.H16116@flint.arm.linux.org.uk>
	 <3F31BDA3.7040700@ghz.cc> <20030807204553.3c5f432e.sfr@canb.auug.org.au>
	 <20030807120056.B17690@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060264234.3123.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 14:50:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 12:00, Russell King wrote:
> Well, it all works fine with 2.4, even with a 3c59x in the slot (except
> for the resume problem.)  Even ejecting the card before suspending with
> 2.6 doesn't fix the problem though.

The 2.4 apm scripts handled a lot of this, could it be the 2.6 PCMCIA 
suspend simply isnt turning off enough things to convince the BIOS ?

