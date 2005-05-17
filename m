Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVEQDpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVEQDpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVEQDpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:45:15 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:16791 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261318AbVEQDo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:44:28 -0400
Message-ID: <4289682B.8060403@enterprise.bidmc.harvard.edu>
Date: Mon, 16 May 2005 23:42:35 -0400
From: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dmitry Torokhov <dtor_core@ameritech.net>, Greg Stark <gsstark@mit.edu>
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as
 /dev/input/mouse0
References: <87zmuveoty.fsf@stark.xeocode.com> <200505160036.30628.dtor_core@ameritech.net>
In-Reply-To: <200505160036.30628.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On Monday 16 May 2005 00:12, Greg Stark wrote:
>  
>
>>I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
>>keyboard.
>>
>Please use /dev/input/mice for accessing your mouse.
>

One possibly interesting mouse issue in 2.6.12-rc[1..4] is that when 
using /dev/psaux, I have found that my mouse cursor under GPM seems to 
be triggered into un-hiding when I issue some random number of 
non-hiding key-down events.  That is, press and release the keyboard 
shift key say 3 or 5 or 10 times, and the console mouse cursor will 
appear, just as if the mouse had been moved.  This bug is not in 2.6.11 
(nor Alan's 2.6.11-ac7, fwiw).

Kris
