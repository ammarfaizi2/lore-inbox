Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVFMO2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVFMO2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVFMO2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:28:17 -0400
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:51145 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261582AbVFMO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:28:04 -0400
Message-ID: <42AD97E5.10600@tremplin-utc.net>
Date: Mon, 13 Jun 2005 16:27:49 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: quade <quade@hsnr.de>, linux-kernel@vger.kernel.org
Subject: Re: latency error (~2ms) with nanosleep
References: <20050613133047.GA11979@hsnr.de> <Pine.LNX.4.61.0506131011370.16830@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0506131011370.16830@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/13/2005 04:21 PM, Richard B. Johnson wrote/a écrit:
> 
> nanosleep, according to the documation is supposed to sleep
> "at least" the 'struct timespec' time. It can return in
> a shorter time as a result of a signal and, if so, the
> input time-values will be updated accordingly. The resolution
> is limited to the HZ value. This means that it will, unless
> interrupted, always sleep at least 1 / HZ seconds (about 1 ms
> on current x86 distributions).
> 
> FYI, there is no 'fine resolution' timer available on any
> Linux-ported platform that could take advantage of the nanosecond
> input resolution of the function.
> 
I could add that there is a project working on this issue: 
high-resolution timers . You can download patches for 2.6 and 2.4 . The 
precision is in the order of 10 or 100 µs.

Eric
