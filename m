Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289297AbSBDXng>; Mon, 4 Feb 2002 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289291AbSBDXn3>; Mon, 4 Feb 2002 18:43:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63928 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289297AbSBDXnR>;
	Mon, 4 Feb 2002 18:43:17 -0500
Date: Tue, 5 Feb 2002 02:41:03 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5F1B0A.DD38E4D0@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202050239050.21719-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Jussi Laako wrote:

> I can renice this only for testing purposes. Normally these are not
> run as root so I can't do negative renice.

by the way, i'm thinking about allowing unpriviledged tasks to go back to
nice -5. But i fear it will be abused and people will just put a renice
into their .bashrc which defeats the purpose of this.

	Ingo

