Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUGXX1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUGXX1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 19:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUGXX1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 19:27:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63457 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263040AbUGXX1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 19:27:52 -0400
Date: Sun, 25 Jul 2004 01:27:12 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: H?ctor Mart?n <hector@marcansoft.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic
Message-ID: <20040725012712.A15785@electric-eye.fr.zoreil.com>
References: <4102CF17.2010207@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4102CF17.2010207@marcansoft.com>; from hector@marcansoft.com on Sat, Jul 24, 2004 at 11:05:27PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H?ctor Mart?n <hector@marcansoft.com> :
[...]
> Interrupt 9 is surely busy, no USB hardware plugged in just in case you're
> wondering, and normally (while not using eth2) interrupt 9 is rock solid
> (i.e. I doubt ACPI interrupts at all during normal use unless e.g. the power
> button is pressed.)

At 60 kirq/s without any network traffic, you may disable acpi then usb
and eventually poke your nose in the bios setup first. No joke.

--
Ueimor
