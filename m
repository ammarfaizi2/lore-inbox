Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLKV0t>; Mon, 11 Dec 2000 16:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130307AbQLKV0j>; Mon, 11 Dec 2000 16:26:39 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:57092 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129383AbQLKV01>;
	Mon, 11 Dec 2000 16:26:27 -0500
Date: Mon, 11 Dec 2000 21:55:51 +0100
From: Martin Mares <mj@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthew Galgoci <mgalgoci@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: cardbus pirq conflict
Message-ID: <20001211215551.B390@albireo.ucw.cz>
In-Reply-To: <20001211150323.C16986@redhat.com> <Pine.LNX.4.10.10012111225010.1458-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012111225010.1458-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 11, 2000 at 12:30:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

> My tentative fix for this would be to make Linux never assign bus #1 or #2
> to a cardbus bridge, and start cardbus bridges at bus #8 or something like
> that.  That way we'd still catch any strangeness in the pirq table, but we
> wouldn't get the message for this case which seems to be very common.

Agreed.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
CChheecckk yyoouurr dduupplleexx sswwiittcchh..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
