Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBGMny>; Wed, 7 Feb 2001 07:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRBGMno>; Wed, 7 Feb 2001 07:43:44 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:10763 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S129072AbRBGMne>; Wed, 7 Feb 2001 07:43:34 -0500
Date: Wed, 7 Feb 2001 04:43:19 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Matt Bernstein <matt@theBachChoir.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: increasing the 512 process limit at run-time?
In-Reply-To: <Pine.LNX.4.33.0102071059540.8811-100000@r2-pc>
Message-ID: <Pine.LNX.4.32.0102070439520.15577-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Matt ,  At what uptime does one hit this limit ?
uptime
  4:40am  up 444 days, 12:58,  1 user,  load average: 0.00, 0.00, 0.00
uname -a
Linux filesrv2 2.2.6 #1 SMP Thu Jul 1 20:33:30 PDT 1999 i686 unknown

	Not that that is anything spectacular , just looking for
	rough idea of uptime before hitting the NR_TASKS limit .
		Tia ,  JimL

On Wed, 7 Feb 2001, Matt Bernstein wrote:
> I note that include/linux/tasks.h contains #define NR_TASKS 512
>
> Can I tune this at run-time? My lovely server's been up since the day
> 2.2.16 was released, and now having hit the limit I don't want to reboot :)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
