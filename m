Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTL2QB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTL2QB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:01:58 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:19937 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263564AbTL2QB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:01:57 -0500
Message-ID: <3FF04FF3.70006@elegiac.net>
Date: Mon, 29 Dec 2003 17:01:55 +0100
From: dju` <dju.ml@elegiac.net>
Organization: [elgc]
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 + logitech wheel mouse optical usb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tested 2.6.0 and I found something weird with my mouse (which used 
to work well with 2.4).

Clicking on the mouse buttons does nothing for about 15% of the clicks 
(using the wheel has this behaviour too) for the first hour of uptime.

After an hour uptime, this behaviour seems to disappear and clicks and 
wheels do the things expected.

Tested on the console with gpm: same thing.

Tested with my logitech internet navigator keyboard, which emulates the 
wheel mouse and the mouse buttons: it works normally. Only the mouse is 
affected.

Rebooted with psmouse_noext=1 didn't change anything. I think this 
option is for ps2 mice though.
Any message in the kernel logs that could help.

Well I can't play Q3A within the first hour after having booted my box, 
has anybody got explanations about that bug? Thanks.

Please CC me as I don't subscribe to the list.
-- 
--dju`
