Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTJTIpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJTIpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:45:15 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:1287 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S262444AbTJTIpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:45:12 -0400
Message-ID: <3F93A093.9060800@2gen.com>
Date: Mon, 20 Oct 2003 10:45:07 +0200
From: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suspend with 2.6.0-test7-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been playing with the suspend features of 2.6.0-test7-mm1 and I 
can't get it to work. When I do "echo -n standby > /sys/power/state", 
the screen flickers briefly and then the system is back to normal. In 
the logs I see the following message:

Oct 20 10:18:12 hansolo kernel: PM: Preparing system for suspend
Oct 20 10:18:12 hansolo kernel: Stopping tasks: 
============================================================================|
Oct 20 10:18:12 hansolo kernel: Restarting tasks... done

Now, I wonder, what is causing the kernel to exit from the suspend 
immediately? Is it error in suspend code, drivers that doesn't support 
suspend or some program that is interrupting the sleep? How do I debug 
this further?

More hw/software info available on request, please CC me on any replies.

Kind regards,
David Härdeman
david@2gen.com

