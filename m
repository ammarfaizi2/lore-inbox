Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbRGBSXu>; Mon, 2 Jul 2001 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265390AbRGBSXk>; Mon, 2 Jul 2001 14:23:40 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:46562 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S265382AbRGBSXd>; Mon, 2 Jul 2001 14:23:33 -0400
Date: Mon, 2 Jul 2001 21:23:16 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org,
        Enforcer <enforcer@ddx.a2000.nu>
Subject: [OT] Re: Strange errors in /var/log/messages
Message-ID: <20010702212316.X1503@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.30.0107021800410.5490-100000@ddx.a2000.nu> <Pine.LNX.3.95.1010702125419.5216A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010702125419.5216A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Jul 02, 2001 at 01:00:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 01:00:33PM -0400, you [Richard B. Johnson] claimed:
> > Jul  2 15:12:16 gateway SERVER[1240]: Dispatch_input: bad request line
> > 'BBXXXXXXXXXXXXXXXXXX%.176u%3
> > 00$nsecurity.%301$n%302$n%.192u%303$n\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> > 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 
> I think you just got 'rooted'. Look at /etc/inetd.conf (if it exists
> on your system, the xinetd is more robust). It may have a new entry
> on its last line providing a root shell to anybody. This looks somewhat
> like an attack shown by CERN about 6 to 12 months ago.

(This has nothing to do with linux-kernel, sorry...)

I don't think anything particular in that message suggests he actually got
rooted? It just seems that somebody tried to exploit lprNG hole (or
something else) and the daemon logged that. Of course, it *is* perfectly
possible, that he _got_ rooted (although he said he was running redhat-7.0
with all the updates). 

(The attacker may have tried other attacks so if he got rooted, those above
are not necessarily the related log messages. In any case, a 'smart' intruder
would have cleaned the log. Also, 'smart' attacker propably uses something
more advanced as backdoor than /etc/inetd.conf these days.)

Or is there something that actually indicates a succesfull intrusion in the
log snippet that I'm missing?


-- v --

v@iki.fi
