Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLOSaS>; Fri, 15 Dec 2000 13:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130131AbQLOSaI>; Fri, 15 Dec 2000 13:30:08 -0500
Received: from linuxpc1.lauterbach.com ([194.195.165.177]:12811 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S129669AbQLOS36>; Fri, 15 Dec 2000 13:29:58 -0500
Message-Id: <4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 15 Dec 2000 18:59:24 +0100
To: Andrea Arcangeli <andrea@suse.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: 2.2.18 signal.h
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
In-Reply-To: <20001215184325.B17781@inspiron.random>
In-Reply-To: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>
 <20001215175632.A17781@inspiron.random>
 <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:43 15.12.00, Andrea Arcangeli wrote:
>On Fri, Dec 15, 2000 at 12:07:55PM -0500, Richard B. Johnson wrote:
> > Current code makes perfect sense if you put a 'break;' after the last
>
>Current code makes perfect sense also without the break. I guess that's a
>strict check to try to catch bugs, but calling it "deprecated" is wrong, it
>should only say "warning: make sure that's not a bug" (when -Wall is enabled).

It's required by ISO C, and since that's the standard now, gcc spits out a 
warning. Just adding a ; is enough and already done for most stuff in 
2.4.0-test12.

Franz.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
