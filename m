Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSB0L40>; Wed, 27 Feb 2002 06:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292346AbSB0L4Q>; Wed, 27 Feb 2002 06:56:16 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:60125 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S291314AbSB0L4N>;
	Wed, 27 Feb 2002 06:56:13 -0500
Date: Wed, 27 Feb 2002 12:56:11 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227125611.A20415@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020226164044.A7726@stud.ntnu.no> <20020226.185630.104030430.davem@redhat.com> <20020227120549.A8734@stud.ntnu.no> <20020227.033455.13771237.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227.033455.13771237.davem@redhat.com>; from davem@redhat.com on Wed, Feb 27, 2002 at 03:34:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> What did it print out when you changed the code to
> be "while (1)"?  It must print something different.

Here's the output (counter is something I added inside the while (1)
{}-loop, on top in that loop, it's unsigned int, set to 0 to start with):

tg3.c:v0.90 (Feb 25, 2002)
DEBUG: counter 6592
DEBUG: smallest_limit is 10000
DEBUG: read_partno returned -19
tg3: Problem fetching invariants of chip, aborting.

smallest_limit is naturally 10k since limit isn't decremented...

-- 
Thomas
