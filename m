Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292962AbSB1AlR>; Wed, 27 Feb 2002 19:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293086AbSB1AlG>; Wed, 27 Feb 2002 19:41:06 -0500
Received: from www.transvirtual.com ([206.14.214.140]:48657 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293104AbSB1Akt>; Wed, 27 Feb 2002 19:40:49 -0500
Date: Wed, 27 Feb 2002 16:40:35 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ben Clifford <benc@hawaga.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2 oops
In-Reply-To: <Pine.LNX.4.33.0202271633120.11102-100000@barbarella.hawaga.org.uk>
Message-ID: <Pine.LNX.4.10.10202271639490.13029-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > http://www.transvirtual.com/~jsimmons/console/console_8.diff
> >
> > Okay. This time I believe I see what caused the oops. Give it a try again.
> 
> Yes, that cures both the oopses when mingetty runs and the oops when X
> starts up.

Okay. Then it was a probable of pm_con being NULL. I added a sanity test
for that. Now to send the patch to David Jones.



