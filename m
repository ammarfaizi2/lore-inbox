Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319510AbSIMEQK>; Fri, 13 Sep 2002 00:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319513AbSIMEQJ>; Fri, 13 Sep 2002 00:16:09 -0400
Received: from ip68-9-69-200.ri.ri.cox.net ([68.9.69.200]:47702 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S319510AbSIMEQI>; Fri, 13 Sep 2002 00:16:08 -0400
Message-ID: <3D8167A0.1080009@blue-labs.org>
Date: Fri, 13 Sep 2002 00:20:48 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020824
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Spamcop
References: <20020912211056.J4739@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrmm...

Actually the URL indicates that your IP is not and should not be listed 
as a spammer now:


    Metric
    ------------------------------------------------------------------------
    Qty
    ------------------------------------------------------------------------
    Most Recent
    ------------------------------------------------------------------------
    Oldest
    ------------------------------------------------------------------------
    Sample traffic: 116 8.22 hours ago
    Thu Sep 12 19:46:12 2002 GMT Thu Sep 12 15:46:12 2002 -0400 6.84
    days ago
    Fri Sep 6 07:43:01 2002 GMT Fri Sep 6 03:43:01 2002 -0400
    Trap recipients: None recorded
    Spam reports: 1 12.12 hours ago
    Thu Sep 12 15:52:19 2002 GMT Thu Sep 12 11:52:19 2002 -0400 12.12
    hours ago
    Thu Sep 12 15:52:19 2002 GMT Thu Sep 12 11:52:19 2002 -0400
    Relaying reports: None recorded
    Relay closed: None recorded

    195.92.249.252 not listed in bl.spamcop.net.
    195.92.249.252 *is not* and *should not be* listed.
    Recent spam increases spam score from 1.00 to 2.00 - spam report
    ratio (0.017) falls under threshold (0.020)



It was listed and promptly delisted three hours later.  No anti-spam 
measure is perfect, all have flaws and all are an inconvenience to some 
portion of users and admins.  SpamCop is quite decent about fixing 
incorrect listings.  Some people argue for proactive listing, some 
people demand 3 sets of proof before listing.

Anti-spam measures are gonna make admins happy and annoyed depending on 
what side of the fence they are on when it hits.  If it's affecting you 
negatively, it's an "idiotic measure", if it's affecting someone else 
instead, it's a "proactive and great idea".  Some measures need evolving 
and tuning, caching, etc.  I.e. my smtp call back mechanism that annoyed 
vger admins.  Yes I need to cache data but as to the veracity of it 
being idiotic...doubtful.  I measure greater than ~70% dead on accuracy 
in tagging spam which makes it pretty darn useful for my users with 
-only- smtp callback.  It has false negatives but it hasn't yet had a 
false positive.

Everyone gets irate when they are incorrectly blacklisted.  Even more 
irate when major mail distributers agree with the BL site policies.  In 
time tho things will get smoothed out.  I/we mail admins feel the pain. 
 Grit your teeth and bear it when these things happen.  No person or 
method is perfect :)

David

Russell King wrote:

>Hi,
>
>I'd like to bring to peoples attention the idiotic situation going on
>with the RBL list known as spamcop.
>
>spamcop have entered into their database the IP address for
>www.linux.org.uk, which is a machine containing many mailing lists
>and other facilities.  www.linux.org.uk is NOT, repeat NOT an open
>relay, and as far as I'm aware has never performed any open relaying.
>
>However, the basis under which it has been listed is that spamcop
>received a mailman reponse to a message their tester sent to a valid
>mailing list address.  The mailman response was:
>
>"Subject: Your message to Linux-arm awaits moderator approval"
>
>Obviously, it didn't relay the spam, nor the test message.
>
>
>If spamcop is accepting hosts with mailing lists that send responses
>back to the person sending the original mail, any mailing list is open
>to being listed in the spamcop database.
>
>My advice is: stay FAR away from spamcop.  If you're using spamcop
>on your mail server, remove it now before they cut you off from all
>your mailing lists.
>
>Here's the URL explaining why www.linux.org.uk has been listed:
>
>   http://spamcop.net/w3m?action=checkblock&ip=195.92.249.252
>
>(Note: this does mean that some kernel people may not be able to
>post messages for a while.  Hence the vague relevance of this
>message to lkml.)
>
>  
>

-- 
I may have the information you need and I may choose only HTML.  It's up to
you. Disclaimer: I am not responsible for any email that you send me nor am
I bound to any obligation to deal with any received email in any given
fashion.  If you send me spam or a virus, I may in whole or part send you
50,000 return copies of it. I may also publically announce any and all
emails and post them to message boards, news sites, and even parody sites. 
I may also mark them up, cut and paste, print, and staple them to telephone
poles for the enjoyment of people without internet access.  This is not a
confidential medium and your assumption that your email can or will be
handled confidentially is akin to baring your backside, burying your head in
the ground, and thinking nobody can see you butt nekkid and in plain view
for miles away.  Don't be a cluebert, buy one from K-mart today.


