Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261797AbREVOdn>; Tue, 22 May 2001 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbREVOde>; Tue, 22 May 2001 10:33:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4619 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261790AbREVOdS>; Tue, 22 May 2001 10:33:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>, Alexander Viro <viro@math.psu.edu>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Mon, 21 May 2001 22:14:30 +0200
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0105211155530.17263-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0105211155530.17263-100000@waste.org>
MIME-Version: 1.0
Message-Id: <01052122143002.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 May 2001 19:16, Oliver Xymoron wrote:
> What I'd like to see:
>
> - An interface for registering an array of related devices (almost
> always two: raw and ctl) and their legacy device numbers with a
> single userspace callout that does whatever /dev/ creation needs to
> be done. Thus, naming and permissions live in user space. No "device
> node is also a directory" weirdness...

Could you be specific about what is weird about it?

> ...which is overkill in the vast majority of cases.

--
Daniel

