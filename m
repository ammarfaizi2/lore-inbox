Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTKYKvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTKYKvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:51:37 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:27064 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262321AbTKYKvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:51:36 -0500
To: jt@hpl.hp.com
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
References: <20031124235727.GA2467@bougret.hpl.hp.com>
	<Pine.LNX.4.58.0311241759470.1599@home.osdl.org>
	<Pine.LNX.4.58.0311241819030.1599@home.osdl.org>
	<20031125025605.GA4059@bougret.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 25 Nov 2003 05:41:24 -0500
In-Reply-To: <20031125025605.GA4059@bougret.hpl.hp.com>
Message-ID: <yq0k75oivcb.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jean" == Jean Tourrilhes <jt@bougret.hpl.hp.com> writes:

Jean> 	Don't get me wrong, PCI-CardBus add-on cards seem to always be
Jean> a pain, whereas laptop seems to always have the right magic. I
Jean> already tried unsuccessfully to add a TI PCI-Pcmcia on another
Jean> box, and this was similar, whereas my laptops are always working
Jean> out of the box.  If you wonder why I'm doing that, well, there
Jean> is not many SMP laptops to try wireless driver on ;-)

Actualy no, Sony laptops are notorious for getting the interrupt logic
wrong with the Ricoh cardbus chips. Without ACPI IRQ routing enabled
you don't see a thing on those laptops.

Cheers,
Jes
