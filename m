Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTLKHYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTLKHYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:24:31 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:5014 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264494AbTLKHY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:24:26 -0500
Message-ID: <3FD81BA4.8070602@cyberone.com.au>
Date: Thu, 11 Dec 2003 18:24:20 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au>
In-Reply-To: <3FD7F1B9.5080100@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> http://www.kerneltrap.org/~npiggin/w26/
> Against 2.6.0-test11


Oh, this patchset also (mostly) cures my pet hate for the
last few months: VolanoMark on the NUMA.

http://www.kerneltrap.org/~npiggin/w26/vmark.html

The "average" plot for w26 I think is a little misleading because
it got an unlucky result on the second last point making it look
like its has a downward curve. It is usually more linear with a
sharp downward spike at 150 rooms like the "maximum" plot.

Don't ask me why it runs out of steam at 150 rooms. hackbench does
something similar. I think it might be due to some resource running
short, or a scalability problem somewhere else.

