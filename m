Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSBDO2k>; Mon, 4 Feb 2002 09:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288948AbSBDO2a>; Mon, 4 Feb 2002 09:28:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24293 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288685AbSBDO2U>;
	Mon, 4 Feb 2002 09:28:20 -0500
Date: Mon, 4 Feb 2002 17:26:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: Re: [patch] O(1) scheduler, -K2
In-Reply-To: <Pine.LNX.4.30.0202041521200.22987-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0202041725260.8800-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Roy Sigurd Karlsbakk wrote:

> Today, the O(1) seems to be quite incompatible with Tux. Will you be
> merging these two together, or is that a no-go?

sure, i'll merge them. There are no big conceptual issues. I think the
only thing that needs to be done is to change the ->cpus_allowed setting
to set_cpus_allowed().

	Ingo

