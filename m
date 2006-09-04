Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWIDW0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWIDW0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWIDW0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:26:18 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:44181 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932139AbWIDW0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:26:16 -0400
Date: Tue, 5 Sep 2006 00:26:14 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x60 - spontaneous thermal shutdown
Message-ID: <20060904222614.GA1614@rhlx01.fht-esslingen.de>
References: <20060904214059.GA1702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904214059.GA1702@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 04, 2006 at 11:40:59PM +0200, Pavel Machek wrote:
> Hi!
> 
> x60 shut down after quite a while of uptime, in period of quite heavy
> load:
> 
> Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
> Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
> Sep  4 23:34:42 amd init: Switching to runlevel: 0
> 
> I do not think cpu reached 128C, as I still have my machine... Did
> anyone else see that?

Could this be in any way related to the (in)famous Random Shutdown issues
on a little too many Apple MacBooks?
(since the x60 incidentally just happens to be Core Duo architecture, too)

Those Random Shutdown issues at least in several cases appear to happen
due to trouble with the temperature sensor or mainboard issues.
Thermal management is in quite some trouble there, judging from
the rather diverse aspects of machine shutdown failure...
(fan not working, CPU overheating, NOT overheating but shutting down
directly after boot, ...)

There's nothing like rushing out immature hardware to unsuspecting consumers...

Andreas Mohr
