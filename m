Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXKKP>; Wed, 24 Jan 2001 05:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRAXKKM>; Wed, 24 Jan 2001 05:10:12 -0500
Received: from nef.ens.fr ([129.199.96.32]:28678 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S129401AbRAXKJl>;
	Wed, 24 Jan 2001 05:09:41 -0500
Date: Wed, 24 Jan 2001 11:09:37 +0100
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010124110937.A9695@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010124100240.A4526@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010124100240.A4526@athlon.random> you write:
> I know this code has undefined behaviour at _runtime_. But I thought
> you were obliged to allow it to compile. That was my only point.

There is no distinction between compilation and runtime in the standard.
Actually, C could be interpreted, or a very smart compiler could also
think real hard and replace the whole program by an equivalent printf().

Besides, a standard (C99) compiler will reject the 'main' definition.
At least, the return type cannot be implicit anymore.


	--Thomas Pornin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
