Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTGGLkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTGGLkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:40:39 -0400
Received: from mta6-svc.business.ntl.com ([62.253.164.46]:56304 "EHLO
	mta6-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S264905AbTGGLki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:40:38 -0400
Date: Mon, 7 Jul 2003 12:57:17 +0100 (BST)
From: William Gallafent <william.gallafent@virgin.net>
X-X-Sender: williamg@officebedroom.oldvicarage
To: Hakan Lennestal <hakanl@cdt.luth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via-rhine problem with older hardware
In-Reply-To: <Pine.GSO.4.53.0307021639270.24488@delta1>
Message-ID: <Pine.LNX.4.53.0307071255590.2313@officebedroom.oldvicarage>
References: <Pine.GSO.4.53.0307021639270.24488@delta1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Hakan Lennestal wrote:

>
> Hi !
>
> I'm having troubles with newer via-rhine drivers (1.1.17) and older
> via-rhine hardware (VT86C100A [Rhine] (rev 06)).
> With moderate CPU load (10-15 %) and some network load
> (a couple of houndred kbps) I'm repeatedly getting:
>   Jul  1 19:56:52 ip2 kernel: NETDEV WATCHDOG: eth0: transmit timed out
>   Jul  1 19:56:52 ip2 kernel: eth0: Transmit timed out, status 0000, PHY
>   status 782d, resetting...
>
> Everything works just smoothly with via-rhine 1.1.15.
>
> This machine does not have ACPI (or APM) enabled.

I had similar problems a while ago on an AMD 760MP system with APIC
enabled. Have you tried booting 'noapic'? The problem went away with a BIOS
update, too, so make sure you have the latest BIOS.

-- 
Bill Gallafent.
