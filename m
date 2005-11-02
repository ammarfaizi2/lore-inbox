Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVKBN3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVKBN3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVKBN3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:29:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38118 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964982AbVKBN3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:29:22 -0500
Date: Wed, 2 Nov 2005 14:29:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102132929.GA12492@elte.hu>
References: <200511021420.28104.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511021420.28104.pluto@agmk.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,NORMAL_HTTP_TO_IP autolearn=disabled SpamAssassin version=3.0.3
	0.1 NORMAL_HTTP_TO_IP      URI: Uses a dotted-decimal IP address in URL
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paweł Sikora <pluto@agmk.net> wrote:

> Hi Ingo,
> 
> With patch-2.6.14-rt1 I notice below problems:
> 
> 1).
> I'm observing a major system slowdown after several hours of uptime.
> This is a normal workstation (running kde, gcc, etc.).
> Once I got on all open terminals an error message:
> `VFS: file-max limit 51078 reached` and it freezed.

does it get any better with -rt3? Paul has sent a couple of fixes for 
RCU-signal related memory leaks.

> 2).
> During `scp bigfile to another machine` I get an oops:
> http://149.156.124.14/~pluto/tmp/2.6.14-rt2-oops.jpg [796 kB]
> 
> Any ideas?

could you send me your .config?

	Ingo
