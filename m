Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132270AbRBKKsx>; Sun, 11 Feb 2001 05:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132303AbRBKKse>; Sun, 11 Feb 2001 05:48:34 -0500
Received: from [194.213.32.137] ([194.213.32.137]:13060 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132270AbRBKKr3>;
	Sun, 11 Feb 2001 05:47:29 -0500
Message-ID: <20010210224855.D7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 22:48:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: tridge@linuxcare.com, linux-kernel@vger.kernel.org
Cc: junichi_morita@ysv.yokogawa.co.jp, torvalds@transmeta.com
Subject: Re: setting cpu speed on crusoe
In-Reply-To: <20010203223939.40F82659858@au2.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010203223939.40F82659858@au2.samba.org>; from Andrew Tridgell on Sun, Feb 04, 2001 at 09:39:39AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Junichi Morita and I have worked out how to access the crusoe
> "longrun" settings on the crusoe based VAIO. This allows you to enable
> power saving mode and slow the cpu down. It should help battery life a
> lot.

There is no documentation? I thought transmeta is linux-friendly
company ;-).

								Pavel

> the following will enable power saving and set the cpu to the slowest
> speed:
> 
>   setpci -s 0:0.0 a8.b=11
> 
> and this will restore you to max speed:
> 
>   setpci -s 0:0.0 a8.b=0e
> 
> the bits are:
> 
> LRON bit0: long run "on" - I'm not really sure what this does

Did you try just asking linus?

> LRRV bit1-3: cpu speed
> LREN bit4: seems to enable variable speed 


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
