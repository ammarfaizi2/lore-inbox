Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSGATM7>; Mon, 1 Jul 2002 15:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSGATM6>; Mon, 1 Jul 2002 15:12:58 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:28170 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316199AbSGATM5>;
	Mon, 1 Jul 2002 15:12:57 -0400
Date: Mon, 1 Jul 2002 04:41:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map )
Message-ID: <20020701024147.GF829@elf.ucw.cz>
References: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If a device can be accessed by multiple machines concurrently, it should not
> be in driverfs.

You can access scsi disk from 2 machines simultaneously. Its just not
a common case. I believe we still want scsi in driverfs ;-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
