Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRDYNE3>; Wed, 25 Apr 2001 09:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRDYNES>; Wed, 25 Apr 2001 09:04:18 -0400
Received: from [217.27.32.7] ([217.27.32.7]:54864 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S129245AbRDYNED>;
	Wed, 25 Apr 2001 09:04:03 -0400
Date: Wed, 25 Apr 2001 16:00:41 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: imel96@trustix.co.id
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010425160041.B4099@francoudi.com>
Mail-Followup-To: imel96@trustix.co.id,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20010425120319Z135634-682+3531@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010425120319Z135634-682+3531@vger.kernel.org>; from imel96@trustix.co.id on Wed, Apr 25, 2001 at 12:04:26PM +0000
X-Operating-System: Linux leonid.francoudi.com 2.4.3
X-Uptime: 3:51pm  up 6 days,  6:34,  3 users,  load average: 0.17, 0.15, 0.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello imel96@trustix.co.id,

Once you wrote about "Re: [PATCH] Single user linux":
> first, i think i owe you guys apology for didn't make myself
> clear, which is going harder if you irritated.
> even my subject went wrong, as the patch isn't really about
> single user (which confuse some people).
> 
> for those who didn't read that patch, i #define capable(),
> suser(), and fsuser() to 1. the implication is all users
> will have root capabilities.
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
> i haven't catch up with all my mails, but my response to
> some:
> - linux is stable not only because security.
> - linux was designed for multi-user, dos f.eks. is designed
>   for personal use, so does epoc, palmos, mac, etc.
> - i even use plan9 with kfs restrictions disabled sometimes,
>   cause i don't have cpu server, auth server, etc.
> - with that patch, people will still have authentication.
>   so ssh for example, will still prevent illegal access, if
>   you had an exploit you're screwed up anyway.
>   sure httpd will give permission to everybody to browse
>   a computer, but i don't think a notebook need to run it.
> 
> so i guess i deserve opinions instead of flames. the
> approach is from personal use, not the usual server use.
> if you think a server setup is best for all use just say so,
> i'm listening.

Then, is there any advantage over booting linux with "single" option?
LILO: linux single

-- 
 Best regards,
 Leonid Mamtchenkov
 System Administrator

