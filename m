Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131870AbRBMPZW>; Tue, 13 Feb 2001 10:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131930AbRBMPZM>; Tue, 13 Feb 2001 10:25:12 -0500
Received: from web9208.mail.yahoo.com ([216.136.129.41]:17416 "HELO
	web9208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131870AbRBMPZG>; Tue, 13 Feb 2001 10:25:06 -0500
Message-ID: <20010213152459.42571.qmail@web9208.mail.yahoo.com>
Date: Tue, 13 Feb 2001 07:24:59 -0800 (PST)
From: bradley mclain <bradley_kernel@yahoo.com>
Subject: Re: How to install Alan's patches?
To: Thomas Foerster <puckwork@madz.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010213150328Z131694-514+4497@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from linux (/usr/src/linux) directory, if the patch is
up a level (/usr/src):

patch -p1 <../patch-2.4.1-ac9

hth,

bradley mclain

ps -- probably a google search with the string 'how to
install ac patches' will find some instructions for
you.

--- Thomas Foerster <puckwork@madz.net> wrote:
> Hi folks,
> 
> sorry for the silly question, but i can't get it to
> work :
> 
> I have linux-2.4.1 unpacked, configured and
> installed.
> Now i want to apply Alan Cox patche
> (linux-2.4.1-ac9), but i always get
> these errors :
> 
> [root@space src]# cat /home/puck/patch-2.4.1-ac9 |
> patch -p0
> can't find file to patch at input line 4
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |diff -u --new-file --recursive --exclude-from
> /usr/src/exclude linux.vanilla/CREDITS
> linux.ac/CREDITS
> |--- linux.vanilla/CREDITS      Wed Jan 31 22:05:29
> 2001
> |+++ linux.ac/CREDITS   Fri Feb  9 13:19:13 2001
> --------------------------
> File to patch: 
> [root@space src]#
> 
> Do i have to create linux.vanilla and linux.ac, or
> what's the magic?! :-)
> 
> Thanx a lot,
>   Thomas
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
