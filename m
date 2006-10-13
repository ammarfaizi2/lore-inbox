Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWJMPPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWJMPPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWJMPPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:15:21 -0400
Received: from bay0-omc2-s34.bay0.hotmail.com ([65.54.246.170]:64568 "EHLO
	bay0-omc2-s34.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751162AbWJMPPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:15:20 -0400
Message-ID: <BAY20-F4691FE413F6BC817BB94AD80A0@phx.gbl>
X-Originating-IP: [80.178.105.199]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <20061013144844.GB5512@ucw.cz>
From: "Burman Yan" <yan_952@hotmail.com>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HP mobile data protection system driver take 2
Date: Fri, 13 Oct 2006 17:15:16 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Oct 2006 15:15:19.0484 (UTC) FILETIME=[653437C0:01C6EEDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>From: Pavel Machek <pavel@ucw.cz>
>To: Burman Yan <yan_952@hotmail.com>
>CC: linux-kernel@vger.kernel.org

>Is sysfs interface compatible to hdaps one?

Well, pretty close:
1) calibrate and position attributes behave the same (as far as I can tell 
by looking at hdaps source)
2) mdps has options to enable/disable mouse and power, but lacks variance, 
temp and
{keyboard,mouse}_activity

But hdapsd only uses position and mouse/keyboard activity stuff. mouse, 
keyboard activity
I can't provide for a simple reason that the chip does not give it to me 
(got the spec).
But since position is in the same format, it should be relatively easy to 
make hdaps work
with mdps as well.

Yan

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

