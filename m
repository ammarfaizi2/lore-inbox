Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbRAFFOi>; Sat, 6 Jan 2001 00:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132133AbRAFFO2>; Sat, 6 Jan 2001 00:14:28 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:24486 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130348AbRAFFOV>; Sat, 6 Jan 2001 00:14:21 -0500
Message-ID: <3A56A9A9.ADC5755A@haque.net>
Date: Sat, 06 Jan 2001 00:14:17 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ullrich <chris@chrullrich.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Even slower NFS mounting with 2.4.0
In-Reply-To: <20010106002531.A490@christian.chrullrich.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm. I'm not seeing this problem on my setups. 

Did you send details about your configurationlast time .. Could you
resend?

Christian Ullrich wrote:
> 
> Hello!
> 
> About three weeks ago, I complained loudly about very slow NFS mounts
> involving a 2.2.17 server and a 2.2.18 client.
> 
> Today, I complain loudly about *extremely* slow NFS mounts
> with the very same server and the same client now running 2.4.0.
> 
> Using 2.2.18, every mount took about 15 seconds, now, using 2.4.0,
> every mount takes exactly five minutes, which is way too long.
> 
> According to syslog, the server begins and completes its operations
> related to the mount in under one second, so it seems to me that
> mount on the client just takes a nap in D state.
> Although the messages in the client's syslog look critical to me,
> once the fs is mounted, it works fine.
> 
> Syslog on client:
> 
> Jan  6 00:18:06 c kernel: portmap: server localhost not responding, timed out
> Jan  6 00:19:46 c kernel: portmap: server localhost not responding, timed out
> Jan  6 00:19:46 c kernel: lockd_up: makesock failed, error=-5
> Jan  6 00:21:26 c kernel: portmap: server localhost not responding, timed out
> 
> I called the mount command five minutes before the final message above.
> 
> I tried NFS with and without NFSv3 code, with no change at all.
> 
> Please help me.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
