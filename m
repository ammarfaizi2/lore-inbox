Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSLLRZz>; Thu, 12 Dec 2002 12:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSLLRZz>; Thu, 12 Dec 2002 12:25:55 -0500
Received: from [203.199.93.15] ([203.199.93.15]:21253 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S264885AbSLLRZw>; Thu, 12 Dec 2002 12:25:52 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200212121725.WAA28045@WS0005.indiatimes.com>
To: "Harlan Jillson" <Harlan.Jillson@pathfinderlwd.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Re: RH 8.0 vs. RH7.3 driver issues
Date: Thu, 12 Dec 2002 22:50:32 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HZ value for i686 has been modified from 100 to 512 in RH 8.0.
If you use this HZ value directly in your driver and , it could be a problem.

Warm Regards
Arun

"Harlan Jillson" wrote:



hi all,
I just subscribed to the list, and am looking for some suggestions.
I have a device driver for a RS485 card that does microlan
communications between several devices. The driver was written a couple
of years ago using the 2.2 kernel in RH 6.1. It's was updated for 2.4
kernel when RH7.3 was released and has been working fine. RH8.0 is
apparently a different story, as there appears to be problems with
scheduled timeouts (polling intervals) and maybe some interrupt issues.
My question is are there any known problems ( RH kernel 2.4.18-3)? I
know I'm dealing the revamps in the scheduler and timer areas and then
there's the shift from gcc 2.96 to 3.2. 
Thanks for any suggestions,
Harlan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy the best in Movies at http://www.videos.indiatimes.com

Change the way you talk. Indiatimes presents Valufon, Your PC to Phone service with clear voice at rates far less than the normal ISD rates. Go to http://www.valufon.indiatimes.com. Choose your plan. BUY NOW.

