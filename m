Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSKDDNH>; Sun, 3 Nov 2002 22:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKDDNH>; Sun, 3 Nov 2002 22:13:07 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60372 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264638AbSKDDNG>; Sun, 3 Nov 2002 22:13:06 -0500
Message-ID: <3DC5E744.9020508@nortelnetworks.com>
Date: Sun, 03 Nov 2002 22:19:32 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE BUG REPORT: 2.5.45 killed my / partition -- partially recovered
References: <3DC5C3A9.3060608@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it turns out that the reason I couldn't boot was a conflict 
between the boot time checks and devfs (with devfs on /dev/hdb9 didn't 
exist...).  If I turned off devfs loading at boot everything went okay.

However, there *were* those problems that fsck.ext3 found and I'm still 
kind of suspicious about them.


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

