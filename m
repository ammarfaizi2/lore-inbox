Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273320AbRINGr3>; Fri, 14 Sep 2001 02:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273321AbRINGrJ>; Fri, 14 Sep 2001 02:47:09 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:7541 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S273320AbRINGrC>; Fri, 14 Sep 2001 02:47:02 -0400
Date: Fri, 14 Sep 2001 01:47:16 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Val Henson <val@nmt.edu>
cc: Tom Rini <trini@kernel.crashing.org>, becker@scyld.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
In-Reply-To: <20010914001540.B2951@boardwalk>
Message-ID: <Pine.LNX.3.96.1010914014353.8683A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Val Henson wrote:
> You misunderstood what I meant.  This is the first case of one driver
> supporting two different cards, one 10/100 and one 10/100/1000.  All
> the gigabit cards are 10/100/1000 as far as I know.  I still think the
> driver should be listed in both the 100 Mbit and 1000 Mbit Ethernet
> menu sections, unless someone comes up with a better idea.

Please do not add duplicate items...  put drivers that can do gigabit
under gigabit.  Eventually as we get more of them we can come up
with better Config.in categories.  Besides being an ugly solution,
duplicating items has the potential to push edge cases in the various
Config.in parsers.

	Jeff



