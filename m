Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVKUXh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVKUXh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVKUXh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:37:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:971 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932483AbVKUXh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:37:57 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051121230136.GB19212@kroah.com>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 10:35:32 +1100
Message-Id: <1132616132.26560.62.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 15:01 -0800, Greg KH wrote:

> If you, or your company is relying on closed source kernel modules, your
> days are numbered.  And what are you going to do, and how are you going
> to explain things to your bosses and your customers, if possibly,
> something like this patch were to be accepted?

I'm all about it, but good luck trying to convince ATI and/or nVidia ...

For those who haven't noticed, the latest generation of ATI cards have a
new 2D engine that is completely different from the previous one and
totally undocumented. So far, they haven't showed any plans to provide
any kind of documentation for it, unlike what they did for previous
chipsets, not even 2D and not even under NDA. That means absolutely _0_
support for it in linux or X.org except maybe with some future version
of their binary blob, and _0_ support for it for any non-x86
architecture of course.

At least nVidia still sort-of maintains the obfuscated but working &
opensource basic 2D driver ... 

On the graphics front, things are actually getting _worse_ everyday.

Ben.



