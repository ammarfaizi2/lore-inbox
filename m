Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVDDQEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVDDQEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDDQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:04:41 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28820 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261264AbVDDQEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:04:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: luming.yu@intel.com
Subject: Re: [ACPI] 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Mon, 4 Apr 2005 18:04:56 +0200
User-Agent: KMail/1.7.1
Cc: acpi-devel@lists.sourceforge.net, "LKML" <linux-kernel@vger.kernel.org>
References: <200503291156.19112.rjw@sisk.pl> <200504011151.48468.rjw@sisk.pl> <200504041734.23178.luming.yu@intel.com>
In-Reply-To: <200504041734.23178.luming.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504041804.57166.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 4 of April 2005 11:34, Yu, Luming wrote:
> Please testing patch filed at
> http://bugzilla.kernel.org/show_bug.cgi?id=3851#c64
> My testing results on toshiba satellite M20 is:
> 
> /proc/acpi/battery/BAT0#time cat state
> present:                 yes
> capacity state:          ok
> charging state:          charging
> present rate:            1500 mA
> remaining capacity:      4064 mAh
> present voltage:         15000 mV
> 
> real    0m0.023s
> user    0m0.000s
> sys     0m0.020s

Here's my result on Asus L5D ("plain" 2.6.12-rc1-mm3 with the patch):

rafael@albercik:/proc/acpi/battery/BAT0> time cat state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            unknown
remaining capacity:      unknown
present voltage:         unknown

real    0m15.113s
user    0m0.000s
sys     0m0.034s

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
