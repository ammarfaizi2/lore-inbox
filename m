Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUALRFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUALRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:05:52 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:26060 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266218AbUALRFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:05:51 -0500
Date: Mon, 12 Jan 2004 17:04:21 +0000
From: Dave Jones <davej@redhat.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, thomas@winischhofer.net,
       linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-ID: <20040112170421.GN14674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	thomas@winischhofer.net, linux-kernel@vger.kernel.org,
	jsimmons@infradead.org
References: <20040109014003.3d925e54.akpm@osdl.org> <200401120121.12122.gene.heskett@verizon.net> <20040112163357.GA20815@redhat.com> <200401121200.19166.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401121200.19166.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 12:00:19PM -0500, Gene Heskett wrote:

 > Are you saying I should turn it on, but just not select a specific 
 > makers chip-boardset?  Or that I should go get a different card?

Might as well turn it off completely. You have an Nvidia card, and
that isn't supported by DRI. (AGPGART is just a soft-dependancy for AGP
based cards that DRI supports)

 > But, I'm thinking of building another, and certainly open for video 
 > card suggestions within the 'utility' price range.

Apart from the integrated chipsets from Intel/VIA etc sadly, there's really
not much in the graphics world that has 100% opensource drivers any more.
Basically, forget it for the high performance end of the market.
(And these days, even most of the commodity stuff (NVIDIA, ATI etc) falls
 into that bracket)
 
		Dave

