Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVKUItI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVKUItI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKUItI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:49:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:59790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932230AbVKUItH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:49:07 -0500
Message-ID: <438189ED.3080305@suse.de>
Date: Mon, 21 Nov 2005 09:48:45 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain> <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain> <20051120235550.GI2556@spitz.ucw.cz>
In-Reply-To: <20051120235550.GI2556@spitz.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Sat 19-11-05 20:25:07, Alan Cox wrote:

>> The latest kernels support command passthrough for SMART and the like
>> but hdparm -S does not "switch off" anything. It may spin a drive down
>> but the power consumption of 23 hours a day of "spun down" is
>> significant, probably more than the hour it is powered up.
> 
> Really? Harddrive does not contain AC/DC converters, so situation should be slightly
> better there, no?

it is 7.5W vs. 0.9W (idle vs standby or sleep) on a Barracuda 120GB
7200rpm desktop drive. Notebook drives are doing better:

0.65W vs 0.25W (idle vs standby) or
0.65W vs 0.1W  (idle vs sleep) on some Hitachi Travelstar.

Better than nothing, but pulling the plug is even better :-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
