Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270931AbRHNX3I>; Tue, 14 Aug 2001 19:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270936AbRHNX27>; Tue, 14 Aug 2001 19:28:59 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:41478 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S270931AbRHNX2x>; Tue, 14 Aug 2001 19:28:53 -0400
Message-ID: <3B79B43D.B9350226@delusion.de>
Date: Wed, 15 Aug 2001 01:29:01 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac5
In-Reply-To: <20010814221556.A7704@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> *
> *       This is a fairly experimental -ac so please treat it with care
> *
> 
> 2.4.8-ac5

Hi Alan,

2.4.8-ac5 makes the kpnpbios kernel thread go zombie here every time right
during boot. I know that 2.4.8-ac1 didn't have this problem, but didn't try
-ac2 to -ac4. If you want me to check which -ac release was the last that
got it right, just say and I'll check.

Regards,
Udo.

bash-2.04# ps uxa
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1 13.1  0.0   344  188 ?        S    01:21   0:05 init
root         2  0.0  0.0     0    0 ?        Z    01:21   0:00 [kpnpbios <defunct>]
root         3  0.0  0.0     0    0 ?        SW   01:21   0:00 [keventd]
root         4  3.4  0.0     0    0 ?        SW   01:21   0:01 [kapm-idled]
root         5  0.0  0.0     0    0 ?        SWN  01:21   0:00 [ksoftirqd_CPU0]
root         6  0.0  0.0     0    0 ?        SW   01:21   0:00 [kswapd]
root         7  0.0  0.0     0    0 ?        SW   01:21   0:00 [kreclaimd]
root         8  0.0  0.0     0    0 ?        SW   01:21   0:00 [bdflush]
root         9  0.0  0.0     0    0 ?        SW   01:21   0:00 [kupdated]
root        11  0.0  0.0     0    0 ?        SW   01:21   0:00 [khubd]
...
