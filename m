Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263635AbTCUP0R>; Fri, 21 Mar 2003 10:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263636AbTCUP0R>; Fri, 21 Mar 2003 10:26:17 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:18837 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263635AbTCUP0Q>; Fri, 21 Mar 2003 10:26:16 -0500
Date: Fri, 21 Mar 2003 15:37:13 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65: 3C905 driver doesn't work.
Message-ID: <20030321153704.GA3762@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jos Hulzink <josh@stack.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303211618.36485.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303211618.36485.josh@stack.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 04:18:36PM +0100, Jos Hulzink wrote:

 > 2.5.65 doesn't connect to my network via my network card:
 > 
 > 00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
 > 
 > My switch does show a link, but the dhcpcd negotiation fails, and no activity 
 > is shown.
 > 
 > All kernel logs look normal, no errors, card is detected correctly.

try booting with..
"acpi=off"
"noapic"
"acpi=off noapic"

For me, the third one gets it working again on two boxes.
Without that, packets are sent, but nothing is ever recieved.

		Dave

