Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTLKE0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 23:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTLKE0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 23:26:22 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:8612 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264356AbTLKE0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 23:26:21 -0500
Message-ID: <3FD7F1B9.5080100@cyberone.com.au>
Date: Thu, 11 Dec 2003 15:25:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme>
In-Reply-To: <20031209001412.GG19412@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/w26/
Against 2.6.0-test11

This includes the SMT description for P4. Initial results shows comparable
performance to Ingo's shared runqueue's patch on a dual P4 Xeon.

It also includes the cpu_sibling_map to cpumask patch, which should apply
by itself. There should be very little if any left to make it work with > 2
siblings per package.

A bug causing rare crashes and hangs has been fixed. Its pretty stable on
the NUMAQ and the dual Xeon. Anyone testing should be using this version
please.



