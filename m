Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbTIOO3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTIOO3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:29:17 -0400
Received: from chello080109223066.lancity.graz.surfer.at ([80.109.223.66]:31201
	"EHLO lexx.delysid.org") by vger.kernel.org with ESMTP
	id S261420AbTIOO3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:29:13 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 consumes more power than 2.4?
From: Mario Lang <mlang@delysid.org>
Date: Mon, 15 Sep 2003 16:29:08 +0200
Message-ID: <871xui5dmz.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

While reviewing 2.6 on my laptop, I noticed something
very odd.  Average power consumption is about
200 mA higher compared to 2.4.

I measure this via the /proc/acpi/battery/*/state interface.

Under 2.4, when idle my laptop consumes about
720mA, sometimes even below that.

Under 2.6, the average idle power consumption is about
900mA.

iN both kernels, I have set Performance state 1
(400mhz) before measuring the average power consumption.

Can anyone confirm this observation?

If so, what is causing this?  200mA is quite a lot of difference,
and if this is a true measurement (no ACPI bug),
this might be a serious problem for laptop users.

-- 
CYa,
  Mario
