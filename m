Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbSKSMKX>; Tue, 19 Nov 2002 07:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSKSMKW>; Tue, 19 Nov 2002 07:10:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28390 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265236AbSKSMKS>;
	Tue, 19 Nov 2002 07:10:18 -0500
Date: Tue, 19 Nov 2002 12:15:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mike Dresser <mdresser_l@windsormachine.com>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
Message-ID: <20021119121541.GA27292@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Mike Dresser <mdresser_l@windsormachine.com>,
	list linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0211181714340.1796-100000@router.windsormachine.com> <3DD9688F.8030202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD9688F.8030202@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 05:24:15PM -0500, Jeff Garzik wrote:
 > this is a toughie...   basically that is an invalid PCI ID that should 
 > not occur.  the "00ec" should really be "10ec", but it sounds like there 
 > is a missing bit in the EEPROM where your card's PCI ID is stored.

I had this happen to me last week on a brand new box (never had
anything put into its PCI slots before), Pulled it out, gave the
card contacts a wipe over (even though they didn't *look* dirty)
plugged it back in, and it worked perfectly.

Odd thing was, I googled for the PCI ID that showed up, and all
it turned up was a Don Becker posting suggesting dirty contacts.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
