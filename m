Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVLPEnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVLPEnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLPEnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:43:24 -0500
Received: from [202.67.154.148] ([202.67.154.148]:1464 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S932120AbVLPEnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:43:23 -0500
Message-ID: <43A247AE.2040603@ns666.com>
Date: Fri, 16 Dec 2005 05:50:54 +0100
From: Trilight <trilight@ns666.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: REPOST: Problem kernel 2.6.14.3 / dual xeon w/HT / correction
X-Priority: 2 (High)
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have to correct my previous post;


Machine specs:

Dell Precision workstation 650 / latest dell bios A05
Dual Xeon 2.4 Ghz w/HT

Kernel: 2.6.14.3 (vanilla)


I noticed that the system after X reboots, this time 4, it boots up
successfuly and i see no errors from ACPI during boot. This is without
any boot parameters. Previously i used acpi=off noapic which increased
the chance of a successful boot (not sure about this, didn't count that)

But during those automatic reboots this is the info i could capture (it
did not get logged btw):

"
<cpu0 is detected and described>
...booting processor 1/2 EIP 2000....
inquiring remote apic #1
apic #1 ID failed
apic #1 VERSION failed
apic # SPIV failed
....not responding cpu #1
cannot use it
then the same happens when it goes to the next cpu, only then it says
apic #6 (sometimes #7)
cannot use it
"

The weird thing is that now for example i booted up perfectly,no errors,
no acpi weirdness...is this a kernel issue ? The previous o.s was linux
Redhat ws Enterprise which never had these problems.

I'd greatly appreciate it if some one can give a helping hand or if i
can supply more information. The DSDT table was looked at by an expert
from Dell and he said this could not be the problem i was describing.
