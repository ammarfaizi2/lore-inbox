Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVH2SP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVH2SP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVH2SP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:15:28 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:56778 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1751265AbVH2SP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:15:27 -0400
Date: Mon, 29 Aug 2005 20:15:26 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <823755312.20050829201526@dns.toxicfilms.tv>
To: Nick Warne <nick@linicks.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 new option timer frequency
In-Reply-To: <200508291857.15746.nick@linicks.net>
References: <200508291857.15746.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Two n00b questions here:
> What does this do/what is it for?
I'm no guru, but its something like the resolution of the timer the kernel
runs. More Hz give you shorter timeslices and lower latency. Lower give
longer timeslices and higher latency.

Anybody please correct me if I am wrong here.

> I selected default, 250Hz.  If this is now an option, what was it before?
AFAIK previously we've had here 1000Hz.


Basically, for a server you'd want 100.
For a desktop 250
For a low-latency (eg. working on audio) you'd want 1000

Again, correct me if I am wrong.

Regards,
Maciej


