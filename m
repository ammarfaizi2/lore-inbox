Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUA0BcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA0BcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:32:10 -0500
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:42667 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261193AbUA0BcH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:32:07 -0500
From: Christian Unger <chakkerz@optusnet.com.au>
Reply-To: chakkerz@optusnet.com.au
Organization: naiv.sourceforge.net
To: Neil Macvicar <blackmogu@vfemail.net>
Subject: Re: Total kernel freeze under 2.6.1
Date: Tue, 27 Jan 2004 12:32:17 +1100
User-Agent: KMail/1.5.4
References: <200401261258.39232.blackmogu@vfemail.net>
In-Reply-To: <200401261258.39232.blackmogu@vfemail.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200401271232.17399.chakkerz@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forewarning ... i ain't "qualified" ... heck i couldn't get my gfx card to 
work on 2.6 until yesterday (and i still don't know why that was).

ANYWAY

i got the same symptoms, and the reason it was doing it on my system was that 
in the config i was using in several places it referenced the wrong chipset. 
via instead of nforce2 type thing. 

>From memory it did this all over the place with regards to sound, hdd and 
memory. 
Check
Device Drivers - ATA/ATAPI/MFM/RLL
Character Devices - AGP Support
		  - i2c Support
Sound 

etc ...

I'm sorry if this is completely useless. But it was what was at fault here.
PS there could be others that i can't remember ... just check for the right 
chipset.

-- 
with kind regards,
  Christian Unger

 - < > - < > - < > - < > - < > - < > - < > - < > -
 
  Alt. Email:  chakkerz_dev@optusnet.com.au
  ICQ:         204184156
  Mobile:      0402 268904
  Web:         http://naiv.sourceforge.net

