Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTEZNmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTEZNmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:42:36 -0400
Received: from [213.229.38.66] ([213.229.38.66]:30443 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S264377AbTEZNmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:42:35 -0400
Message-ID: <3ED21CE3.9060400@winischhofer.net>
Date: Mon, 26 May 2003 15:55:47 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x 
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How many samples of the SiS650 did you have for testing?

I have

-) a 650 (host bridge ID 1039:0650, rev 01),
    with ISA bridge (1039:0008) revision 0x00,
-) a M650 (host bridge ID 1039:0650, rev 11),
    with ISA bridge (1039:0008) revision 0x04, and
-) a 651 (host bridge ID 1039:0651, rev 02),
    with ISA bridge (1039:0008) revision 0x25

and I had (and have) no problems with irqs or USB (or anything) on any 
of these machines.

Are you sure that checking the revision number of the device is enough?

Are you aware of the fact that SiS only produces the chips but never the 
mainboards, and that SiS chips are in a 1000 ways "customizible" which 
not in a single case I came accross so far was detectable by the device 
revision number?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



