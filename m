Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWIGSwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWIGSwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWIGSwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:52:33 -0400
Received: from hermes.domdv.de ([193.102.202.1]:14088 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1751046AbWIGSwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:52:32 -0400
Message-ID: <45006A6F.8030801@domdv.de>
Date: Thu, 07 Sep 2006 20:52:31 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, len.brown@intel.com
Subject: [2.6.17.8] noapic and /proc/acpi/event
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do have a problem with a new laptop (Acer Ferrari 4006):

It does suspend either to disk or to ram only when I do boot with
"noapic". So far, so good.

If, however, I do boot with "noapic" no events are delivered to
/proc/acpi/event so lid switch and power button can't be used to suspend
anymore.

The strange thing is, that at least in /proc/acpi/button/lid/LID/state I
can view the lid switch state.

Can anybody shed some light on this?
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
