Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVCHSjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVCHSjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVCHSjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:39:40 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:429 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261488AbVCHSjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:39:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=XrWUjDGxDTje1o/vP86mEhlJ9seWx8H8GmRVQn8t2LdPHVc8JE9kBQ9/hQDifpOKli7Y3OkhuHTf7XEhlilgTHWCv2P3kV7DwgYKCo0VfyxZ8n1fScqEvvJWomNlbwRV3WvKuqjRDsyX2/9reC3ssfXTct0rhKY6dtZIuUvEpzM=
Message-ID: <875fe4a50503081039328ffede@mail.gmail.com>
Date: Tue, 8 Mar 2005 18:39:39 +0000
From: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Reply-To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: about interrupt latency
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i'm trying to estimate the interrupt latency (time between hardware
interrrupt and the start of the ISR) of a linux kernel 2.4.29 and i
used a simple tecnique: inside the do_timer_interrupt i read the 8259
counter to obtain the elapsed time.
By this mean i found a latency of about 6/7 microseconds that is very
similar to the time measured in some articles but with CPU much slower
while i expected the latency was shorter on faster CPUs.
So, my questions are: 
1)what's the depency between the interrupt latency and the CPU speed?
2)what are the factors at the origin of th interrupt latency?

Than u very much

Francesco Oppedisano
