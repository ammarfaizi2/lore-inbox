Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTD2OPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 10:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbTD2OO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 10:14:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15251
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262016AbTD2OO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 10:14:58 -0400
Subject: RE: Broadcom BCM4306/BCM2050  support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Martin List-Petersen <martin@list-petersen.dk>, bas.mevissen@hetnet.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1051614381.21135.5.camel@rth.ninka.net>
References: <1051596982.3eae18b640303@roadrunner.hulpsystems.net>
	 <1051614381.21135.5.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051622911.18198.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Apr 2003 14:28:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-29 at 12:06, David S. Miller wrote:
> Don't expect specs or opensource drivers for any of these pieces
> of hardware until these vendors figure out a way to hide the frequency
> programming interface.

People are already cracking the windows interfaces on them

> The only halfway plausible idea I've seen is to not document the
> frequency programming registers, and users get a "region" key file that
> has opaque register values to program into the appropriate registers.
> The file is per-region (one for US, Germany, etc.)and the wireless
> kernel driver reads in this file to do the frequency programming.

I talked to one vendor about this stuff and fingers crossed we will see
open drivers except for the radio module. In the longer term I suspect
vendors will move to signed register sets, so you can load "US 802.11g"
but you can't load "police frequency, full power"

> So don't blame the vendors on this one, several of them would love
> to publish drivers public for their cards, but simply cannot with
> upsetting federal regulators.

And non US ones too. The fact people are already abusing the technology
suggests that they will be forced to go the crypted settings route for
next generation hardware anyway.

Alan

