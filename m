Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275302AbTHIRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275297AbTHIRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:55:56 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:29647 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S275302AbTHIRzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:55:51 -0400
Date: Sat, 9 Aug 2003 13:55:50 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: linux-kernel@vger.kernel.org
Subject: bogomips calibration failed
Message-ID: <20030809175550.GA31836@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I came up with a new problem on my new P IV box running 2.6-test3 now
(problem existed before also on test2 kernels)

First I had problem with APIC but it seems it is (I hope) resolved now
though it might be not true cause when I run bogomips after machine is
already up but not loaded with any task it fails to calibrate to compute
bogomips. If I load machine with lets say kernel compilation or
distributed-net then it says some bogomips - around 1600 when on boot
for each "logical" processor it states around 4719.

configuration and some dumps are available from
http://www.onerussian.com/bogo/

dmesg seems to don't state any failed boot of the driver.

Thank you in advance for giving me a hint where to look.


                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
