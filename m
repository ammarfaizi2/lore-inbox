Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSBUWVA>; Thu, 21 Feb 2002 17:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSBUWUu>; Thu, 21 Feb 2002 17:20:50 -0500
Received: from suntan.tandem.com ([192.216.221.8]:63483 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S281214AbSBUWUd>; Thu, 21 Feb 2002 17:20:33 -0500
Message-ID: <3C756C7C.29A7C2BD@compaq.com>
Date: Thu, 21 Feb 2002 13:54:04 -0800
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kendrick M. Smith" <kmsmith@umich.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
In-Reply-To: <Pine.SOL.4.33.0202211255240.9973-100000@robotron.gpcc.itd.umich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kendrick M. Smith" wrote:
> I just returned from vacation and saw this thread.  I also need trylock()
> routines for read-write semaphores for NFS version 4, but you're way ahead
> of me: I hadn't even started to implement them yet, and have been working
> around the deficiency.  So I would really like to see some variant of this
> patch go into the 2.5.x series eventually.  Anything I can do to help out?


Can you test it on 2.5? It applies cleanly and builds with 2.5.3, but I
was having trouble booting the 2.5 kernel on RedHat 7.2. Not needing to
work on 2.5 just yet, I gave up rather quickly and just tested on 2.4.

Anyway, I can send you my test patch and a brief description of what I
looked for to make sure it was working on 2.4.

-- 
Brian Watson                | "Now I don't know, but I been told it's
Linux Kernel Developer      |  hard to run with the weight of gold,
Open SSI Clustering Project |  Other hand I heard it said, it's
Compaq Computer Corp        |  just as hard with the weight of lead."
Los Angeles, CA             |     -Robert Hunter, 1970

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
