Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135668AbRAWCsa>; Mon, 22 Jan 2001 21:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135732AbRAWCsU>; Mon, 22 Jan 2001 21:48:20 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:61494 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135668AbRAWCsO>; Mon, 22 Jan 2001 21:48:14 -0500
Message-ID: <3A6CF0C7.E0D836E3@linux.com>
Date: Tue, 23 Jan 2001 02:47:35 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rainer Mager <rmager@vgkk.com>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Is this kernel related (signal 11)?
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGOEKCCNAA.rmager@vgkk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Mager wrote:

> > Would this be an SMP IA32 box with glibc 2.2? I have two such boxen
> > showing exactly the same behaviour, although I can't reproduce it at will.
>
> Close, it is actually an SMP IA32 box with glibc 2.1.3. But you've now
> convinced me to not upgrade glibc yet  ;-)

Upgrade -past- 2.2, get 2.2.1.  2.2 causes numerous segfaults, notably sendmail
and apache stop working.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
