Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbVBEAaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbVBEAaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBEAY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:24:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:63459 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265319AbVBEASG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:18:06 -0500
Subject: Re: 2.6.11-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6u7jlng9b0.fsf@zork.zork.net>
References: <20050204103350.241a907a.akpm@osdl.org>
	 <6ud5vgezqx.fsf@zork.zork.net> <1107561472.2363.125.camel@gaston>
	 <6u7jlng9b0.fsf@zork.zork.net>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 11:16:49 +1100
Message-Id: <1107562609.2363.134.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I tried it two or three times, same result each time.  I'll give it a
> lash with USB disabled.

Also, can you try editing arch/ppc/syslib/open_pic.c, in function
openpic_resume(), comment out the call to openpic_reset() and let me
know if that helps...

Ben.


