Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbSLRSS7>; Wed, 18 Dec 2002 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbSLRSS7>; Wed, 18 Dec 2002 13:18:59 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56475 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267319AbSLRSS6>;
	Wed, 18 Dec 2002 13:18:58 -0500
Date: Wed, 18 Dec 2002 18:26:18 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Nathan Neulinger <nneul@umr.edu>
Cc: linux-kernel@vger.kernel.org, uetrecht@umr.edu
Subject: Re: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 series cards
Message-ID: <20021218182618.GA30832@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Nathan Neulinger <nneul@umr.edu>, linux-kernel@vger.kernel.org,
	uetrecht@umr.edu
References: <20021218181052.GA26465@umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218181052.GA26465@umr.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 12:10:54PM -0600, Nathan Neulinger wrote:
 > According to 3Ware, the driver in the 2.4.x and (I assume) 2.5.x is no
 > longer compatible with the 6xxx series cards. 
 > I don't know what we'll do with this situation when we move to 2.6, cause
 > right now, it looks like we are completely screwed. The old driver 
 > obviously will not compile on 2.6 since the API's have changed. 

Any idea at which point the 2.5 driver stopped working ?
It may not be that much work to bring that version up to date as
a 3ware-old.c driver in a worse-case scenario.

This would be huge code duplication however, and would be much
better fixed by having the driver detect which card its running
on, and 'do the right thing' wrt which firmware it needs.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
