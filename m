Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWGUUN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWGUUN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWGUUN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 16:13:28 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:31185 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751139AbWGUUN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 16:13:28 -0400
Message-ID: <44C13563.4010307@cmu.edu>
Date: Fri, 21 Jul 2006 16:13:23 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: ACPI bombing, ACPI Exception (acpi_bus-0071): AE_NOT_FOUND
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I am running a 2.6.18-rc1-git7 kernel on my IBM Thinkpad x60s, with
CONFIG_ACPI_DOCK=y

Whenever the computer is inserted into the dock, ACPI seems to bomb:
http://rafb.net/paste/results/GW5E8747.html

I was wondering if anyone could help me solve this problem, I believe it
is keeping me from using my cdrom drive on the dock since it does not
show up in /dev.  I have also contacted Kristen Accardi about it, who I
believe wrote the dock code... but I wasn't sure if this is a further
problem in ACPI somewhere.

Here is my full config:
http://rafb.net/paste/results/o2gSVu90.html

Thanks!
George
