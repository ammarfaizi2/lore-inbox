Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUAGF61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUAGF61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:58:27 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:22194 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266138AbUAGF60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:58:26 -0500
Date: Wed, 7 Jan 2004 05:55:57 +0000
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adam Belay <ambx1@neo.rr.com>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040107055557.GA13812@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andi Kleen <ak@colin2.muc.de>, Linus Torvalds <torvalds@osdl.org>,
	Adam Belay <ambx1@neo.rr.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	"Grover, Andrew" <andrew.grover@intel.com>
References: <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com> <Pine.LNX.4.58.0401062000490.12602@home.osdl.org> <20040107050256.GA4351@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107050256.GA4351@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 06:02:56AM +0100, Andi Kleen wrote:
 > > > 5.) Look into other ways of finding out if the PnPBIOS might be buggy,
 > > > currently we only have DMI.
 > > > Any others?
 > > We could use the exception mechanism, and try to fix up any BIOS errors. 
 > > That would require:
 > 
 > [...] It would not work for x86-64 unfortunately where you cannot do 
 > any BIOS calls after the system is running (it would only be possible
 > early in boot) 

Why on earth would you want to call PNPBIOS on AMD64 anyway ?

		Dave

