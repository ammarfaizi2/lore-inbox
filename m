Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbRLPRcV>; Sun, 16 Dec 2001 12:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLPRcL>; Sun, 16 Dec 2001 12:32:11 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:32726 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284732AbRLPRb6>; Sun, 16 Dec 2001 12:31:58 -0500
Date: Sun, 16 Dec 2001 19:33:35 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][OOPS] loop block device induced on 2.5.1-pre11+HIGHMEM
In-Reply-To: <Pine.LNX.4.33.0112162022530.12588-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112161932440.23025-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Ingo Molnar wrote:

> yes, it's a valid configuration. Eg. distribution makers are frequently
> using highmem-enabled kernels - and it's a natural thing that they boot &
> work just fine on non-highmem boxes as well. Also, even a highmem box
> could have a RAM failure anytime that forces a temporary removal of RAM,
> causing the box to have no highmem RAM anymore, in which situation it
> would be pretty awkward if the highmem-enabled kernel failed.

Thanks, i'll try the patch this evening when i get home and give you the
lowdown.

Cheers,
	Zwane Mwaikambo


