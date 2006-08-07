Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWHGDHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWHGDHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 23:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWHGDHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 23:07:47 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:37457 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750965AbWHGDHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 23:07:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uZ3Jdwo/jh22x798gM+/kTKo+U/USAe/i7zKHct2xrLqZo4DIMdpwJfG85762gXbOMU96YOaDMMp3ZwSdur7QEQyBOLBWRWmEjzaYrm65cPW6SUpYySuupGKguYBBmNTWJyjSYTFAbjJV0RJXRQ/uwlm7S8MGY85RoMkuhg7FDg=
Message-ID: <44D6AE59.6070709@gmail.com>
Date: Mon, 07 Aug 2006 12:07:05 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Harald Dunkel <harald.dunkel@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidsen@tmr.com
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <20060805212346.GE5417@ucw.cz>
In-Reply-To: <20060805212346.GE5417@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
> 
> Really? I thought power/state takes 0/3 (for D0 and D3)

Yes, of course.  My mistake.  Sorry about the confusion.  The correct 
command is 'echo -n 3 > /sys/bus/scsi/devices/x:y:z:w/power/state'.

-- 
tejun
