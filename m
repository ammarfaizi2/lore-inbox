Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVGSUwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVGSUwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVGSUwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:52:10 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:15118 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261630AbVGSUwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:52:03 -0400
Message-ID: <42DD67D9.60201@stud.feec.vutbr.cz>
Date: Tue, 19 Jul 2005 22:51:37 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: amd64-agp vs. swsusp
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does resuming from swsuspend work for anyone with amd64-agp loaded?

On my system when I suspend with amd64-agp loaded, I get a spontaneous 
reboot on resume. It reboots immediately after reading the saved image 
from disk.
This is 100% reproducible.

Athlon 64 FX-53, Asus A8V Deluxe, Linux 2.6.13-rc3-mm1.

Regards,
Michal
