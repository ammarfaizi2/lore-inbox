Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVCHGAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVCHGAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCHGAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:00:34 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:21443 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261532AbVCHGAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:00:17 -0500
Date: Tue, 08 Mar 2005 01:00:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: setserial is lieing to us, how to fix?
In-reply-to: <20050308050518.6822.qmail@manson.clss.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503080100.14246.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050308050518.6822.qmail@manson.clss.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 March 2005 00:05, Alan Curry wrote:
>Gene Heskett writes the following:
>>I'm on the horn with another linux user, and we have a question re
>> the setserial command.  Its reporting the base baud rate, but not
>> the actual.  We need to know the actual settings in use at the
>> moment for a serial port. How can we discover this?
>
>stty speed -F /dev/ttyXY
>
Just what the doctor ordered, many thanks.

>The setserial spd_* options can affect speed but they are obsolete
> so you shouldn't be using them. If stty says 38400 then the
> setserial spd_* is in effect. If spd_normal, then 38400 means
> 38400. If spd_hi, then 38400 means 57600. If spd_vhi, then 38400
> means 115200. If spd_shi, then 38400 means 230400. If spd_warp,
> then 38400 means 460800. Then there's spd_cust, which is more
> weird.
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
