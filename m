Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRBENSD>; Mon, 5 Feb 2001 08:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132781AbRBENRx>; Mon, 5 Feb 2001 08:17:53 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:59631 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132706AbRBENRt>; Mon, 5 Feb 2001 08:17:49 -0500
Message-ID: <3A7EA9B3.3507DC8D@uow.edu.au>
Date: Tue, 06 Feb 2001 00:25:07 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Hacksaw <hacksaw@hacksaw.org>
CC: Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: Your message of "Sun, 04 Feb 2001 09:18:43 PST."
	             <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> <200102041804.f14I4br22433@habitrail.home.fools-errant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hacksaw wrote:
> 
> >I've discovered that heavy use of vesafb can be a major source of clock
> >drift on my system, especially if I don't specify "ypan" or "ywrap". On my
> 
> This is extremely interesting. What version of ntp are you using?

Is vesafb one of the drivers which blocks interrupts for (many) tens
of milliseconds?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
