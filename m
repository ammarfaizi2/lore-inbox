Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUKBXQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUKBXQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUKBXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:14:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:40886 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262515AbUKBXHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:07:14 -0500
Subject: Re: 2.6.8 Thinkpad T40, clock running too fast
From: john stultz <johnstul@us.ibm.com>
To: Shawn Willden <shawn-lkml@willden.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200411021551.53253.shawn-lkml@willden.org>
References: <200411021551.53253.shawn-lkml@willden.org>
Content-Type: text/plain
Message-Id: <1099436816.9139.28.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 02 Nov 2004 15:06:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 14:51, Shawn Willden wrote:
> I'm having a problem with the clock on my Thinkpad running too fast.  My clock
> is gaining about 4 seconds every five minutes of operation.  I'm actually not
> sure when this started because NTP has been fairly successful at keeping my
> clock under control, so I didn't really notice it until I spent some time
> operating disconnected... and then it became very obvious very quickly.

Does this go away if you disable cpufreq in your kernel config?

Also, looking at /proc/interrupts, does it look like you're getting more
then ~1000 interrupts per second?

thanks
-john


