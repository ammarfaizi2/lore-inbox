Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTLPABF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTLPABF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:01:05 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:47832 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264284AbTLPABD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:01:03 -0500
Message-ID: <3FDE41BC.8000305@cyberone.com.au>
Date: Tue, 16 Dec 2003 10:20:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au> <Pine.LNX.4.58.0312151517290.2102@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0312151517290.2102@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:

>Hello Nick,
>	This is somewhat unrelated to the current thread topic direction,
>but i noticed that your HT scheduler really behaves oddly when the box is
>used interactively. The one application which really seemed to be
>misbehaving was 'gaim', whenever someone typed a message X11 would pause
>for a second or so until the text displayed causing the mouse to jump
>around erratically. I can try help with this but unfortunately i can't do
>too much rebooting this week due to work (main workstation), but perhaps
>we can discuss it over a weekend. The system is 4x logical 2.0GHz.
>

Hi Zwane,
Thats weird. I assume you don't have problems with the regular SMP kernel.
Unfortunately I don't have an HT box I can do these sorts of tests with.
The first thing you could try is with CONFIG_SCHED_SMT 'N'.

Nick

