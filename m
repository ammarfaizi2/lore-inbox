Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132008AbRCVN2R>; Thu, 22 Mar 2001 08:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132013AbRCVN2H>; Thu, 22 Mar 2001 08:28:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46809 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132008AbRCVN2C>;
	Thu, 22 Mar 2001 08:28:02 -0500
Message-ID: <3AB9FD99.F601EDE0@mandrakesoft.com>
Date: Thu, 22 Mar 2001 08:26:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: e100.c (SuSE 7.1): udelay() used in a wrong way?
In-Reply-To: <3ABA0537.18043.146E671@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> void
> Phy82562EHDelayMilliseconds(int Time)
> {
>     udelay(Time);
> }
> 
> AFAIK, udelay() delays microseconds, not milliseconds.

Yep, you are correct, and the code is incorrect.

mdelay() delays milliseconds.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
