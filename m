Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSHGRst>; Wed, 7 Aug 2002 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318872AbSHGRst>; Wed, 7 Aug 2002 13:48:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10458 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318850AbSHGRss>;
	Wed, 7 Aug 2002 13:48:48 -0400
Date: Wed, 7 Aug 2002 19:51:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, Marcin Dalecki <dalecki@evision.ag>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
In-Reply-To: <Pine.LNX.4.44.0208071942140.21766-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208071950180.21907-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Aug 2002, Ingo Molnar wrote:

> > What happens under 2.5.30?
> 
> the same 'LI' message.
> 
> I'll try Alan's suggestion of adding the 'linear' option.

this actually did the trick - lilo no more messes up the bootup. So Alan's
suspicion is right, there's something wrong about geometries in
2.5-current.

	Ingo

