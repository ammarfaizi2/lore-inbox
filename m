Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTJTTBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTJTTBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:01:24 -0400
Received: from [65.172.181.6] ([65.172.181.6]:14233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262767AbTJTTBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:01:20 -0400
Date: Mon, 20 Oct 2003 12:10:25 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend with 2.6.0-test7-mm1
In-Reply-To: <3F93A093.9060800@2gen.com>
Message-ID: <Pine.LNX.4.44.0310201209300.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've been playing with the suspend features of 2.6.0-test7-mm1 and I 
> can't get it to work. When I do "echo -n standby > /sys/power/state", 
> the screen flickers briefly and then the system is back to normal. In 
> the logs I see the following message:
> 
> Oct 20 10:18:12 hansolo kernel: PM: Preparing system for suspend
> Oct 20 10:18:12 hansolo kernel: Stopping tasks: 
> ============================================================================|
> Oct 20 10:18:12 hansolo kernel: Restarting tasks... done
> 
> Now, I wonder, what is causing the kernel to exit from the suspend 
> immediately? Is it error in suspend code, drivers that doesn't support 
> suspend or some program that is interrupting the sleep? How do I debug 
> this further?
> 
> More hw/software info available on request, please CC me on any replies.

Are you using ACPI? If so, could you please send the output of
/proc/acpi/sleep? If not, then standby will not work for you at this time.

Thanks,


	Pat

