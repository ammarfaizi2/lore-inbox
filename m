Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbTGPAZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269832AbTGPAZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:25:29 -0400
Received: from server102.xantronmail.de.187.86.80.in-addr.arpa ([80.86.187.130]:40397
	"EHLO kunden.xantronkunden1.de") by vger.kernel.org with ESMTP
	id S269259AbTGPAZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:25:28 -0400
Message-ID: <3F149ED0.6080706@jstephan.org>
Date: Wed, 16 Jul 2003 02:39:44 +0200
From: Joerg Stephan <joerg@jstephan.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.0-test1 some Problems (modules & touchpad)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-------- Original Message --------
Subject: 2.6.0-test1 some Problems (modules & touchpad)
Date: Tue, 15 Jul 2003 05:36:41 -0700 (PDT)
From: Panos Christeas <p_christeas@yahoo.com>
To: Joerg Stephan <joerg@jstephan.org>

Please look the older postings.
There is a new handling of Touchpad, as of 2.5.74.
Until the userspace programs (X w/o special driver,
gpm) are adapted, there is a workaround:
preferably compile mouse support as a module (called
'psmouse').
Load the module with a parameter 'modprobe psmouse
psmouse_noext=1' .
You could alternatively pass that parameter to your
kernel boot parameters (if psmouse is not a module).
These are under the 'options' part of LILO, for
example.

This workaround will enable the old PS/2 mode of the
touchpad and X will be able to read events from
'/dev/input/mice'.

ps. please remind the lkml about this. I'm not sending
from my regular address.


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com



