Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTILNuO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 09:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTILNuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 09:50:14 -0400
Received: from saspace.sas.be ([195.207.19.1]:53261 "EHLO
	saspace.spaceapplications.com") by vger.kernel.org with ESMTP
	id S261699AbTILNuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 09:50:11 -0400
Message-ID: <3F61CF12.9020602@abcpages.com>
Date: Fri, 12 Sep 2003 15:50:10 +0200
From: Nicolae Mihalache <mache@abcpages.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6-test4 problems: suspend and touchpad
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a Acer Travelmate 800 laptop and I'm using SuSE Linux 8.2 on it.
I tried recenly to install linux 2.6 and I observe two main problems:
1. The touchpad(synaptics) does not work. In kernel 2.4/X11 4.3  it 
works very well both as a generic ps2 mouse or as a synaptics (using X11 
driver for synaptics). The kernel 2.6 seems to have included a driver 
for the synaptics device, it is detected at boot, but it does not work 
in X (I guess it must be some kind of conflict between X11 driver and 
kernel driver?).

2. suspend/resume. With version 2.6test2+acpi patch both swsusp and 
"echo 3 >/proc/acpi/sleep" worked, being able to somehow successfully 
resume. In version 2.6test4 there is no /proc/acpi/sleep and swsusp 
hangs somwhere during an IDE call (I can hand-copy the trace if needed).

Any ideea?
mache

