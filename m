Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSLPNup>; Mon, 16 Dec 2002 08:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSLPNup>; Mon, 16 Dec 2002 08:50:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:58514 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262420AbSLPNuo>;
	Mon, 16 Dec 2002 08:50:44 -0500
Date: Mon, 16 Dec 2002 13:58:13 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops 2.5.51] PnPBIOS: cat /proc/bus/pnp/escd
Message-ID: <20021216135813.GD11616@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Paul <set@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021215230344.GE1432@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021215230344.GE1432@squish.home.loc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 	'cat /proc/bus/pnp/escd' consistantly produces this:

 > EIP:    0088:[<00007b74>]    Not tainted

You blew up in BIOS code. Your BIOS has a crap PNPBIOS implementation.
Send the output of dmidecode[1] and it can get added to the blacklist.

[1] http://people.redhat.com/arjanv/dmidecode.c

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
