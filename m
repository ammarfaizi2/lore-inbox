Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbRDYNmY>; Wed, 25 Apr 2001 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRDYNmP>; Wed, 25 Apr 2001 09:42:15 -0400
Received: from viper.haque.net ([66.88.179.82]:21443 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135380AbRDYNmE>;
	Wed, 25 Apr 2001 09:42:04 -0400
Message-ID: <3AE6D427.F0C469D4@haque.net>
Date: Wed, 25 Apr 2001 09:41:58 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <20010425120319Z135634-682+3531@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:
> for those who didn't read that patch, i #define capable(),
> suser(), and fsuser() to 1. the implication is all users
> will have root capabilities.

And this is better than just having the system auto-login as root because......?


> 
> then i tried to bring up the single user thing to hear
> opinions (not flames). and by that, i actually didn't mean
> to have users share the same uid/gid 0. i know somebody
> will need to differentiate user.
> 
> so when everybody suggested playing with login, getty, etc.
> i know you have got the wrong idea. if i wanted to play
> on user space, i'd rather use capset() to set all users
> capability to "all cap". that's the perfect equivalent.
> 
> so the user space solution (capset()) works, but then came
> the idea to optimize away. that's what blow everybody up.
> don't get me wrong, i always agree with rik farrow when he
> wrote in ;login: that we should build software with security
> in mind.
> 
> but i also hate bloat. lets not go to arm devices, how about
> a notebook. it's a personal thing, naturally to people who
> doesn't know about computer, personal doesn't go with multi
> user. by that i mean user with different capabilities, not
> different persons.
> 

So don't install any services. The security in the kernel is not even
bloat compared to some of the cruft that you can just not install.

> - with that patch, people will still have authentication.
>   so ssh for example, will still prevent illegal access, if
>   you had an exploit you're screwed up anyway.
>   sure httpd will give permission to everybody to browse
>   a computer, but i don't think a notebook need to run it.

See above.

> 
> so i guess i deserve opinions instead of flames. the
> approach is from personal use, not the usual server use.
> if you think a server setup is best for all use just say so,
> i'm listening.

I have Linux on my PowerBook. I don't have sendmail, httpd, mysql, and a
billion other 'server' processes running. Does that still make it a server?

We're not flaming (well some of us anyways). Just pointing out (loudly)
where your thinking is flawed.

> nah, performance was never my consideration. i do save about
> 3kb from my zImage, but i'm not interested.

But you just said you hate bloat. What other reason do you have for
hating bloat?


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
