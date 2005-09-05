Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVIEGUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVIEGUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVIEGUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:20:46 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:3266 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932243AbVIEGUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:20:45 -0400
Message-ID: <36877.10.10.10.10.1125901244.squirrel@linux1>
In-Reply-To: <20050905060405.GA16784@alpha.home.local>
References: <35547.10.10.10.10.1125892279.squirrel@linux1>
    <20050905040311.29623.qmail@web50204.mail.yahoo.com>
    <50570.10.10.10.10.1125893576.squirrel@linux1>
    <20050905043613.GD30279@alpha.home.local>
    <46230.10.10.10.10.1125895623.squirrel@linux1>
    <20050905050108.GA16596@alpha.home.local>
    <59215.10.10.10.10.1125898289.squirrel@linux1>
    <20050905060405.GA16784@alpha.home.local>
Date: Mon, 5 Sep 2005 02:20:44 -0400 (EDT)
Subject: Re: RFC: i386: kill !4KSTACKS
From: "Sean" <seanlkml@sympatico.ca>
To: "Willy Tarreau" <willy@w.ods.org>
Cc: "Alex Davis" <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, September 5, 2005 2:04 am, Willy Tarreau said:

> They don't mind. Those people install Checkpoint on Linux. A product of
> which previous releases were even incompatible with security updates !

Heh.. well all the power to them.  Still no reason for an open source
developer to waste one second worrying about it though.

> You don't get it. One of my collegue installed quagga on his binary-only
> laptop. Now that he found it very useful and showed how to can be used,
> he's planning on setting up servers to run it to bring new services. So
> his *crappy* laptop full of binary-only drivers and relying on ndiswrapper
> allows him to build a proof of concept and get the possibility to run it
> on real hardware.

Same comment.   Someone should create a distribution dedicated to this
market if it's that important.

> Except that someone has to maintain the patch, because with the speed the
> kernel is changing, a patch against 2.6.14 will not work on 2.6.15. I've
> tried UML on 2.4 in the past, and I've learned the hard way not to rely
> on patches for old features when developpers consider them obsolete (2.4
> support ended when 2.6 began).

If enough people are interested in it, it can't be that hard to organize
external maintenance of the patch.  Even these long conversations on the
mailing list show why the bloody thing should be ejected already.  Move it
to it's own tree with it's own mailing list etc..

> Keeping it marked as BROKEN is fine. It may even taint the kernel, that's
> not a problem. Removing it is wrong.

I agree with you that it should taint at a minimum.   But should something
that taints the kernel even be part of the mainline source?

Cheers,
Sean


