Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUD2J1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUD2J1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbUD2J1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:27:39 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:56910 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263979AbUD2J1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:27:36 -0400
Message-ID: <4090CA85.6050009@yahoo.com.au>
Date: Thu, 29 Apr 2004 19:27:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: scheduler latency
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've done some scheduler latency tests and come up with some
pretty plots, so I thought I'd post them. It is nicksched vs
mainline.

Note: this is not realtime scheduling latency, but latency as
measured by my random program. It also does not indicate
interactivity, because the latencies measured were all under
15ms which is probably below perception. Even if not, it
doesn't measure latency as you might see it.

Finally, some of the tests involved me moving the mouse around,
so factor in by subliminal (or not) bias toward my scheduler.

http://www.kerneltrap.org/~npiggin/schedlat3/index.html
