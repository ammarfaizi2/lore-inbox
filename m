Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTEOSGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTEOSGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:06:39 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:35766 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264143AbTEOSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:06:38 -0400
Message-ID: <3EC3DA43.8080404@myrealbox.com>
Date: Thu, 15 May 2003 11:19:47 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tg3 question for Jeff/Dave
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff and Dave,

I posted this in response to Linus's release of 2.5.69 but I don't know
if either of you saw it.

The patches for the Broadcom net driver (tg3) did not fix the problem
I've had with the ASUS A7V8X motherboard which has a Broadcom gigabit
ethernet chip built in.

The problem remains the same:  to get the chip to process packets I
first must do an ifconfig down/up cycle after I reboot the machine,
even though there are no error messages from any of the initscripts
during bootup and the output from ifconfig looks perfect.

Once I do the down/up the Broadcom chip works well until the next reboot,
when the same problem shows up again.  The Broadcom chip apparently is
not fully initialized and winds up in some furshluginner state until
another ifconfig down/up is done.

If I can supply any debugging info please let me know!

Thanks.

