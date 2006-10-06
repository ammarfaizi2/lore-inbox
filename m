Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWJFWI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWJFWI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWJFWI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:08:27 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23275 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932642AbWJFWI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:08:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Sat, 7 Oct 2006 00:01:01 +0200
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jeff@garzik.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <1160132630.3000.98.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0610060906140.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610060906140.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610070001.01752.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 6 October 2006 18:07, Linus Torvalds wrote:
> 
> On Fri, 6 Oct 2006, Arjan van de Ven wrote:
> >
> > we can do a tiny bit better than the current code; some chipsets have
> > the address of the MMIO region stored in their config space; so we can
> > get to that using the old method and validate the acpi code with that.
> 
> Yes. I think trusting ACPI is _always_ a mistake. It's insane. We should 
> never ask the firmware for any data that we can just figure out ourselves.
> 
> And we should tell all hardware companies that firmware tables are stupid, 
> and that we just want to know what the hell the registers MEAN!
> 
> I've certainly tried to tell Intel that. I think they may even have heard 
> me occasionally.
> 
> I can't understand why some people _still_ think ACPI is a good idea..

I violently agree.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

