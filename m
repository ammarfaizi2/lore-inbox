Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284729AbRLPR2L>; Sun, 16 Dec 2001 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284730AbRLPR2B>; Sun, 16 Dec 2001 12:28:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63364 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284729AbRLPR1m>;
	Sun, 16 Dec 2001 12:27:42 -0500
Date: Sun, 16 Dec 2001 20:25:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][OOPS] loop block device induced on 2.5.1-pre11+HIGHMEM
In-Reply-To: <Pine.LNX.4.33.0112161017550.4185-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112162022530.12588-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Dec 2001, Zwane Mwaikambo wrote:

> Then again, is highmem kernel on non-highmem box a valid
> configuration?

yes, it's a valid configuration. Eg. distribution makers are frequently
using highmem-enabled kernels - and it's a natural thing that they boot &
work just fine on non-highmem boxes as well. Also, even a highmem box
could have a RAM failure anytime that forces a temporary removal of RAM,
causing the box to have no highmem RAM anymore, in which situation it
would be pretty awkward if the highmem-enabled kernel failed.

	Ingo

