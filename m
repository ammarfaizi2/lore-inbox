Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbSLRSbX>; Wed, 18 Dec 2002 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSLRSbX>; Wed, 18 Dec 2002 13:31:23 -0500
Received: from 209-76-113-226.ded.pacbell.net ([209.76.113.226]:18996 "EHLO
	siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id <S267228AbSLRSbW>; Wed, 18 Dec 2002 13:31:22 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B812672C927@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Dave Jones'" <davej@codemonkey.org.uk>, Nathan Neulinger <nneul@umr.edu>
Cc: linux-kernel@vger.kernel.org, uetrecht@umr.edu
Subject: RE: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 seri
	es cards
Date: Wed, 18 Dec 2002 10:41:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who from 3ware told you it isn't compatible?  That's totally bogus.  
It's completely compatible.

3ware supports 6, 7, and 8000 series cards with a single driver in 
2.2, 2.4, and 2.5 trees.

If it isn't working for you, let me know.

-Adam

-----Original Message-----
From: Dave Jones [mailto:davej@codemonkey.org.uk]
Sent: Wednesday, December 18, 2002 10:26 AM
To: Nathan Neulinger
Cc: linux-kernel@vger.kernel.org; uetrecht@umr.edu
Subject: Re: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00
series cards


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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
