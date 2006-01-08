Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWAHMAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWAHMAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbWAHMAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:00:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58005 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751365AbWAHMAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:00:43 -0500
Date: Sun, 8 Jan 2006 13:00:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: kernel@kolivas.org
cc: Marco Costalba <mcostalba@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Typo in include/linux/mmzone.h
In-Reply-To: <200601081403.15850.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0601081300220.30148@yvahk01.tjqt.qr>
References: <e5bfff550601071354k2c86afcs62d1526a3a1487cd@mail.gmail.com>
 <200601081403.15850.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> +static inline int populated_zone(struct zone *zone)
>> +{
>> +	return (!!zone->present_pages);
>> +}
>> +
>
>No typo there at all. !! guarantees return of 1.
>
But we do not need the parentheses around it.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
