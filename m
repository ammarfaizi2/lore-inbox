Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292337AbSB0LGI>; Wed, 27 Feb 2002 06:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292131AbSB0LGA>; Wed, 27 Feb 2002 06:06:00 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:49101 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292325AbSB0LFv>; Wed, 27 Feb 2002 06:05:51 -0500
Date: Wed, 27 Feb 2002 12:05:49 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227120549.A8734@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020226145730.A20268@stud.ntnu.no> <20020226.065941.39167730.davem@redhat.com> <20020226164044.A7726@stud.ntnu.no> <20020226.185630.104030430.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020226.185630.104030430.davem@redhat.com>; from davem@redhat.com on Tue, Feb 26, 2002 at 06:56:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> Great, now add the following patch below and let me know what it does
> and prints out now.

tg3.c:v0.90 (Feb 25, 2002)
DEBUG: smallest_limit is 9897
DEBUG: read_partno returned -19
tg3: Problem fetching invariants of chip, aborting.


> If the module still fails to load because of the -EBUSY error (ie. the
> "read_partno returns -19" thing happens again), bring
> drivers/net/tg3.c into an editor and go to around line 4185 and change
> the line that reads:
>  [snipp]
> And see if it works then.  PLEASE type sync a few times before trying
> to load the module in this case as it could very well hang your
> machine.

Didn't work, didn't hang the box either :)

Any more ideas? :)

-- 
Thomas
