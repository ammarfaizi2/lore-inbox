Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbTF3Twy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 15:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbTF3Twy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 15:52:54 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:14333 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S265863AbTF3Twx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 15:52:53 -0400
Message-ID: <3F00986C.6070106@Synopsys.COM>
Date: Mon, 30 Jun 2003 22:07:08 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.73: Module sound_slot_0 not found.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I haven't found this mentioned anywhere, so hopefully you don't mind
me asking.

When I try to access /dev/dsp ("cat /dev/zero >/dev/dsp") I get some
messages like

Jun 30 22:01:20 bilbo modprobe: FATAL: Module sound_slot_0 not found.
Jun 30 22:01:20 bilbo modprobe: FATAL: Module sound_service_0_3 not found.

in syslog. But which module is supposed to be sound_slot_0 ?

The same alsa configuration works without problems together with
kernel 2.4.21 and alsa 0.99.75. Do I have to ignore the included
alsa driver and use the latest version instead?


Regards

Harri



