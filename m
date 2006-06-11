Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWFKHnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFKHnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 03:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFKHnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 03:43:03 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:15632 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1750717AbWFKHnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 03:43:01 -0400
Message-ID: <448C4F38.8030807@internode.on.net>
Date: Sun, 11 Jun 2006 17:13:28 +0000
From: Tom Gaudasinski <cetus@internode.on.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: List of Optical devices.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
    I would like to get a list of all the optical drives registered. I 
see that in <linux/cdrom.h> there is a register_cdrom() function, and an 
unregister variant. Nowhere do i see however a way to get  a list of 
these devices. I understand that they form a linked list, so getting the 
first one would be peachy enough, yet again I can't find such 
functionality. Currently what I'm doing is parsing the text out of 
/proc/sys/dev/cdrom/info, which is cumbersome. However due to the fact 
that a file in proc can produce this, i assume there's a way to get that 
list. How may I do so? All i need are the device names so that I may 
send some ioctls to them.

Thank you.

P.S.
I am not subscribed to the mailing list, please CC me a copy of any replies.
