Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSFSGkL>; Wed, 19 Jun 2002 02:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSFSGkK>; Wed, 19 Jun 2002 02:40:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2964 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317790AbSFSGkJ>;
	Wed, 19 Jun 2002 02:40:09 -0400
Date: Wed, 19 Jun 2002 08:38:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.23 cpu_online_map undeclared
In-Reply-To: <aep588$21j$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206190836540.1691-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Linus Torvalds wrote:

>  static inline void smp_send_reschedule_all(void) { }
> +#define cpu_online_map				1
>  #define cpu_online(cpu)				1

yesterday i've tested a number of UP kernels that had an equivalent fix
and this works as expected, nothing else broke.

	Ingo

