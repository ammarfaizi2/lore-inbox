Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSCFXfz>; Wed, 6 Mar 2002 18:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSCFXfq>; Wed, 6 Mar 2002 18:35:46 -0500
Received: from c007-h013.c007.snv.cp.net ([209.228.33.220]:47835 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S286959AbSCFXfc>;
	Wed, 6 Mar 2002 18:35:32 -0500
X-Sent: 6 Mar 2002 23:35:26 GMT
Message-ID: <3C86A7B6.2BF312FD@bigfoot.com>
Date: Wed, 06 Mar 2002 15:35:18 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre2-Ole i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: laptop losing 4 seconds every 17 minutes [SOLVED]
In-Reply-To: <3C2E65F3.D54E8048@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Moore wrote:
> 
> Toshiba 320CT, 2.2.20.  I noticed a 'synchronization lost' pattern in
> xntpd logs.
> 
> Ran a test loop with 'ntpdate -q' to my LAN time server at 1 second
> intervals and discovered the laptop is losing precisely 4 seconds (jump)
> every 17 minutes.
> 
> There are no unusual cron jobs, nor does any obvious process trigger as
> far as top output shows.  There is an Abit KA7 using the same kernel,
> ntp server and client setup, and on the same LAN with no issues.

Every 1020 seconds the system would freeze, including RTC, for 4
seconds.  In this case '1020+4' had no tangible meaning.  The problem
was a bad NiMH RTC battery.

rgds,
tim.
--
