Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUKCMyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUKCMyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUKCMyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:54:53 -0500
Received: from gprs214-124.eurotel.cz ([160.218.214.124]:129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261581AbUKCMyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:54:49 -0500
Date: Wed, 3 Nov 2004 13:54:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: gcs@lsc.hu, lm@work.bitmover.com
Subject: Example where BKCVS is not detailed enough (and ask for help)
Message-ID: <20041103125432.GB1132@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We are trying to track down ugly bug where machines fail to power down
/ power up at first occassion on 2.6.8.1 + acpi parts from 2.6.9-bk1.

Unfortunately all acpi changes in this area are merged into "BKrev:
412f21c8cj8TLCDiYwWr68kVXtdeXg" => it is not easy to find bug by
binary search. Is there easy way to get split-up patches?

Bjorn: You could probably download individual patches from bkbits.net
by hand and try to revert them one by one.

Others: Is there easier way than that?

Improvement request:

One big change looks like this on cvs log...

[PATCH] USB: USB PhidgetServo driver update

Once again a (small) patch for the phidgetservo driver.

Some servos have a very high maximum angle, set upper limit to the
maximum allowed by the hardware. Reported by Mario Scholz
<mario@expires-0409.mail.trial-n-error.net>

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

2004/08/23 18:06:07+00:00 aegl
Merge agluck-lia64.sc.intel.com:/data/home/aegl/BK/linux-ia64-test-2.6.8.1
into agluck-lia64.sc.intel.com:/data/home/aegl/BK/linux-ia64-release-2.6.8.1

2004/08/18 21:50:56+00:00 jbarnes
[ACPI] ia64 build fix

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

2004/08/18 18:18:02+00:00 kenneth.w.chen

....would it be possible to put some bkrev's or urls for the
individual changes? If I want to find patch corresponding to last
change on bkbits, ... I guess I can only grep for changelog comment.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
