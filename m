Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313847AbSDJVZN>; Wed, 10 Apr 2002 17:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313854AbSDJVZM>; Wed, 10 Apr 2002 17:25:12 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:9396 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313847AbSDJVZL>; Wed, 10 Apr 2002 17:25:11 -0400
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Apr 2002 14:23:23 -0700 (PDT)
Subject: Kernel developer attitudes, a problem to watch for.
Message-ID: <Pine.LNX.4.44.0204101421000.29888-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this message on a thread that I didn't realize wasn't on the list
anymore so I am trimming it and resending it. To avoid offending anyone I
am not refering to the thread that triggered this.


This applies to everyone. any statements in quotes mentioned below are not
intended to be a quote of the people involved, but are instead intended to
summarize an attitude that seems to be common in developers who get into
this situation.

<Soapbox>

Just becouse you have been the person working on a piece of the kernel and
fully understand it and have grand plans for how it should go in the
future still doesn't give you full control over that subsystem. You have
to explain what you are doing and why, just saying 'I know best' doesn't
go over well. Donald Becker had this problem and is no longer the primary
maintainer of network drivers in 2.4+. Dave (I for get the last name but
the networking layer) had this problem for a while, but changed his mode
of operating and has been continuing to contribute. The mess with the VM
system in early 2.4 with Rik was another case, now rik is producing
patches that are being accepted instead of being frustrated that his code
is being tinkered with by 'people who don't know what they are doing' (a
classification that can and does at times include Linus).  There have been
many others (Richard with devfs, aa with the VM stuff, I'm sure anyone who
has watched things for a year or so can name a dozen others) and all start
off saying 'here is my monolithic piece please put it in the kernel' and
those that stick around and contribute over the long term learn to say
'here is this small piece, this is what it does, this is why (and if it
doen't fix anything immediatly, this is what I am working towards). You
also need to expect that other people will produce patches that affect
your code. when this happens you need to either accept them, fix them, or
explain exactly what's wrong with them (and saying ' this will be the end
of the world' or 'it doesn't fit the long term plans' without explaining
those long term plans first isn't good enough). If you don't do this then
you get frustrated when other people 'muck up' your subsystem and when
your fixes are ignored by Linus.

Note specificly that IT DOES NOT MATTER how well you know the subject you
are coding if your code doesn't make it into the kernel or gets removed
and replaced by someone elses version that has problems becouse your grand
plan isn't understood. No one person is such a perfect programmer that
their code as above reproach and criticism. I'm not saying leave your ego
at home, but I am saying you need to not let your ego get so large that
you stop accepting corrections and criticisms from others.

</Soapbox>

This is not an attack on anyone and I apologize if I implied attitudes
that people don't think they have. I am attempting to get everyone to
think a little on the subject as it is something that seems to be a
chronic problem in the kernel development community.

David Lang


