Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131974AbRC1Pwn>; Wed, 28 Mar 2001 10:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131976AbRC1Pwc>; Wed, 28 Mar 2001 10:52:32 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:55302 "EHLO finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP id <S131974AbRC1PwU>; Wed, 28 Mar 2001 10:52:20 -0500
Message-ID: <ZEABaXAGggw6EwTH@sis-domain.demon.co.uk>
Date: Wed, 28 Mar 2001 16:49:26 +0100
To: linux-kernel@vger.kernel.org
From: Simon Williams <announce@sis-domain.demon.co.uk>
Subject: Re: Disturbing news..
References: <01032806093901.11349@tabby> <Pine.GSO.3.96.1010328144551.7198A-100000@laertes> <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk> <20010328100440.A5941@zalem.puupuu.org>
In-Reply-To: <20010328100440.A5941@zalem.puupuu.org>
MIME-Version: 1.0
X-Mailer: Turnpike Integrated Version 5.01 S <Qn604$JeDmmUs1jEKXSOEfAuuD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010328100440.A5941@zalem.puupuu.org>, Olivier Galibert
<galibert@pobox.com> writes
>On Wed, Mar 28, 2001 at 03:04:46PM +0100, Simon Williams wrote:
>> I think their point was that a program could only change permissions
>> of a file that was owned by the same owner.  If a file is owned by a
>> different user & has no write permissions for any user, the program
>> can't modify the file or it's permissions.
>
>You mean, you usually have write permissions for other than the owner
>on executable files?
>
>Let me reformulate that.  You usually have write permissions for other
>than the owner, and not only on some special, untrusted log files (I'm
>talking files, here, not device nodes)?  What's your umask, 0?
>

Firstly, I'm relatively new to Linux (only about 3 yrs experience) &
don't claim to be an expert.  Secondly, I don't think I stated my point
very clearly.

No, I don't have write permissions set on an executable for any user
other than the owner.

What I meant was that if a file is owned by root with permissions of,
say, 555 (r-xr-xr-x), not setuid or setgid, then another executable
run as a non-root user cannot modify it or change the permissions to
7 (rwx).

>
>> Sounds like a good plan to me.
>
>PEBCAK.  Unix security is not designed with dumb "administrators" in
>mind, nor should be.  User friendly is good.  Luser friendly isn't,
>it's either dumbing down or unnecessarily restrictive.
>

I completely agree (even with the PEBCAK part :)).  UNIX security on
corporate networks or public-facing systems should be left to experts.
I, on the other hand, am a home-user trying to learn how Linux works &
how to secure it, I don't pretend to be an expert.

My policy is to give necessary permissions & no more.  I would set the
aforementioned permissions on the main system binaries which would allow
other users to get on with what they need to do without being able to
affect the workspaces of other users, only their own.

I'm open to contructive criticism on this.


-- 
Simon Williams
