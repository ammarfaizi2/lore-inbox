Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUFJXKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUFJXKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUFJXKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:10:10 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18661 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262381AbUFJXKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:10:05 -0400
Message-ID: <40C8EA4B.7070604@enenet.com>
Date: Thu, 10 Jun 2004 19:10:03 -0400
From: Vadim Garber ENEnet <vadim@enenet.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040228)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: touchpad (PS/2) mouse detection problem.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've compiled the 2.6.6 kernel, and I can't seem to get my laptops 
touchpad to get detected.
The touchpad runs on the ps/2 protocol; so it seems like there would be 
no problems with
detection. But of course I'm not a very lucky person ;-). The touchpad 
itself does have an
on/off botton; and I've made sure to keep it ON. This is a strange 
problem because I don't
seem to have it in older kernels (2.4.x). Cat'ing 
/proc/bus/input/devices also doesn't turn up
any useful information; just returns my keyboard (which works; yepi!). 
I've compiled
psmouse both into the kernel and as a module; both don't work.

dmesg only shows "mice: PS/2 mouse device common for all mice" but no 
'input:' line.


Regards,


Vadim Garber
vadim at enenet dot com
