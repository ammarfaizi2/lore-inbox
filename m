Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRIJLuY>; Mon, 10 Sep 2001 07:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270646AbRIJLuO>; Mon, 10 Sep 2001 07:50:14 -0400
Received: from static004-9-151-24.nt02-c4.cpe.charter-ne.com ([24.151.9.4]:9524
	"EHLO Jupiter.LIWAVE.COM") by vger.kernel.org with ESMTP
	id <S270619AbRIJLuA>; Mon, 10 Sep 2001 07:50:00 -0400
Reply-To: <rvandam@liwave.com>
From: "Ron Van Dam" <rvandam@liwave.com>
To: <jdwyatt@bellsouth.net>, <linux-kernel@vger.kernel.org>
Cc: "'Frank Schneider'" <SPATZ1@t-online.de>
Subject: RE: FW: OT: Integrating Directory Services for Linux
Date: Mon, 10 Sep 2001 07:50:10 -0400
Message-ID: <001c01c139ee$bef37330$1f0201c0@w2k001>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <3B9C183D.52FCAD7C@bellsouth.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh wrote:
>>That's just not true anymore, at least not for NDS.  Novell's latest
>>version (called "eDirectory" these days) runs very gracefully on Linux
>>(and solaris, too, FWIW).  It's possible to run an entire NDS
>>infrastructure without running any netware these days.  This has been
>>out for quite awhile.

I am fully aware of eDirectory. However, just like PAM, OpenLDAP, and other
add-on directory tools, it isn't fully adopted or utilized by all of the
Linux tools. Few if any OpenSource projects have embraced NDS. Maybe I'm
wrong, but I don't believe it would ever be adopted as a standard by the
Linux community.

>>Hrm, please qualify that.  Why do you think it's obsolete?  It's
>>considerably more advanced (and certainly more secure) than most of the
>>other options out there, including LDAP-over-SSL.  Just a bitch to
>>admin.

Your last sentence "Just a bitch to admin" sums it up pretty well.

> applications and services.

>>PAM is the standardized and agreed-upon method for divorcing
>>authentication from the system.  It's been like that for quite some time
>>now.  What if this discussion was about some Linux GUI apps not being
>>compatible with X?  The boat's been sailing for quite some time, either
>>hop on or build your own, I say, or swim (sink?).
<snip>
>>What's wrong with the name service switch stuff?  and more importantly,
>>PAM?

In my opinion PAM is a hack, and it breaks a compatibly with a lot of stuff
out there. I really don't care what technology is used to get the job done.
But as I said in a earlier post I don't see how DS can become reality unless
there is a standard supported by everyone.

<snip>
> I started this discussion to see if anyone out there considers DS
important
> for Linux growth.  I am not sugguesting that this should be in the kernel.
> Just some sort of directory system that can manage configurations of a
large
> number of linux boxes.

>>I personally believe that nothing will be so pivotal in a desktop war as
>>a good, unified directory.  Is the desktop a growth area for Linux?  You
>>betcha.  There are other areas (i.e. embedded) that Linux could benefit
>>from directories, too (think of a cellphone that anyone could use by
>>"logging into" it).

Exactly.

>>Who, besides root, would ever need to perform activities before userland
>>processes can start?

Perhaps the kernel? It depends on how deep DS plays a roll on Linux. With
CAP implemented you can lock down the system so that root can't even perform
some tasks.


> How would you manage 1000 or 10,000 desktop boxes each with their own /etc
> directory?  Imagine your supporting several hundred or even several
thousand
> unix boxes, and you need to apply a standard change to all of them. Lets
> also assume your not getting paid by the hour, or you need to get the
change
> done in just a hour or two. Would you trust a running a script on a
> /etc/*.conf file to apply a change on your boxes? I suppose if you really
> like to torture yourself, you could modify each of those files by hand,
> ouch!

>>Agreed, by hand it would be painful.  But why are scripts so scary?
>>Just don't screw up :) .
>>I have played on a team which maintained 1000+ solaris and sunos
>>workstations, each with their own /etc, for a userlist > 7000 users.

What if some less then enthusiastic has semi-mangled a /etc file. Can you
guarantee that the  script will correctly parse and modify it? Scripting
works fine if the machines are completely uniform, but I bet you there are a
lot of sysadmins that would be weary of perform a large scale change on
/etc/*.conf files.

I know I am going to get some dirty looks about this, but also consider the
scenerio that a larger company wants to move off of Windows to Linux for the
desktop. To start off most of your desktop support technicians will NOT be
capable of writing scripts to apply changes. With a DS system in place you
can create admin tools that dumb down the configuration. I know some people
will consider this a week argument,but its true. I believe that in order for
Linux to reach the desktop, there has to be a method to manage them easier
than the current available tools. I think DS is the best approach.

Thanks,
Ron

