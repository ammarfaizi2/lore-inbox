Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271056AbTGPS4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271069AbTGPS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:56:17 -0400
Received: from [66.212.224.118] ([66.212.224.118]:40965 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271056AbTGPS4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:56:13 -0400
Date: Wed, 16 Jul 2003 14:59:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
 installed)
In-Reply-To: <1058196612.3353.2.camel@aurora.localdomain>
Message-ID: <Pine.LNX.4.53.0307160148420.32541@montezuma.mastecende.com>
References: <1058196612.3353.2.camel@aurora.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Trever L. Adams wrote:

> OK, I now get past the initialization of the 3c920.  However, now it
> hangs (sak enabled, sak doesn't work... completely dead) when eth0 tries
> to come up.  I have IPv6 enabled (the router does 6to4, this isn't the
> router), I don't believe I have any firewall stuff on this box, it does
> dhcp for IPv4 address and ntp time.
> 
> There was an oops earlier in the boot process.  It seems the sound card
> (irq 3) did an irq and the kernel wasn't ready to accept so it barfed. 
> There may have been more to it than that, I will check later today.  I
> have to get back to my studies for now.

Can you capture that message? Perhaps your network card and sound card 
share an interrupt?

	Zwane
-- 
function.linuxpower.ca
