Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUAGGKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUAGGKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:10:31 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:39090 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266140AbUAGGKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:10:24 -0500
Date: Wed, 7 Jan 2004 06:08:43 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Adam Belay <ambx1@neo.rr.com>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040107060842.GA22884@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@colin2.muc.de>,
	Adam Belay <ambx1@neo.rr.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	"Grover, Andrew" <andrew.grover@intel.com>
References: <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com> <Pine.LNX.4.58.0401062000490.12602@home.osdl.org> <20040107050256.GA4351@colin2.muc.de> <20040107055557.GA13812@redhat.com> <Pine.LNX.4.58.0401062203040.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401062203040.12602@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 10:06:24PM -0800, Linus Torvalds wrote:

 > > Why on earth would you want to call PNPBIOS on AMD64 anyway ?
 > 
 > For the same reason normal PC's still like to: no technical reason, except
 > for the fact that system vendors like to hide bugs and quirks by having
 > magic stuff in ACPI or PnPBIOS to tell the OS "hands off" or "this is how
 > to route this strange irq".

But PNPBIOS is an ISA relic isn't it ?
No amd64 system I know of even has an ISA bus.

		Dave

