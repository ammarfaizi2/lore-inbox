Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWCHXAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWCHXAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWCHXAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:00:30 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:16772 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030263AbWCHXA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:00:27 -0500
References: <200603081013.44678.kernel@kolivas.org> <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe> <200603081330.56548.kernel@kolivas.org> <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com> <cone.1141787137.882268.19235.501@kolivas.org> <1141852064.21958.28.camel@localhost>
Message-ID: <cone.1141858802.179786.26372.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Zan Lynx <zlynx@acm.org>
Cc: =?ISO-8859-1?B?QW5kcuk=?= Goddard Rosa <andre.goddard@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 09 Mar 2006 10:00:02 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-26372-1141858802-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-26372-1141858802-0001
Content-Type: text/plain; format=flowed; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mimegpg

Zan Lynx writes:

> On Wed, 2006-03-08 at 14:05 +1100, Con Kolivas wrote:
>> Andr=E9 Goddard Rosa writes:
>> 
>> > [...]
>> >> > > Because being a serious desktop operating system that we are
>> >> > > (bwahahahaha) means the user should not have special privileges to=
 run
>> >> > > something as simple as a game. Games should not need special sched=
uling
>> >> > > classes. We can always use 'nice' for a compile though. Real time =
audio
>> >> > > is a completely different world to this.
>> > [...]
>> >> Well as I said in my previous reply, games should _not_ need special
>> >> scheduling classes. They are not written in a real time smart way and =
they do
>> >> not have any realtime constraints or requirements.
>> > 
>> > Sorry Con, but I have to disagree with you on this.
>> > 
>> > Games are very complex software, involving heavy use of hardware resour=
ces
>> > and they also have a lot of time constraints. So, I think they should
>> > use RT priorities
>> > if it is necessary to get the resources needed in time.
>> 
>> Excellent, I've opened the can of worms.
>> 
>> Yes, games are a in incredibly complex beast.
>> 
>> No they shouldn't need real time scheduling to work well if they are code=
d 
>> properly. However, witness the fact that most of our games are windows 
>> ports, therefore being lower quality than the original. Witness also the 
>> fact that at last with dual core support, lots and lots (but not all) of 
>> windows games on _windows_ are having scheduling trouble and jerky playba=
ck, 
>> forcing them to crappily force binding to one cpu.
> [snip]
> 
> Games where you notice frame-rate chop because the *disk system* is
> using too much CPU are perfect examples of applications that should be
> using real-time.
> 
> Multiple CPU cores and multithreading in games is another perfect
> example of programming that *needs* predictable real-time thread
> priorities.  There is no other way to guarantee that physics processing
> takes priority over graphics updates or AI, once each task becomes
> separated from a monolithic main loop and spread over several CPU cores.
> 
> Because games often *are* badly written, a user-friendly Linux gaming
> system does need a high-priority real-time task watching for a special
> keystroke, like C-A-Del for example, so that it can kill the other
> real-time tasks and return to the UI shell.
> 
> Games and real-time go together like they were made for each other.

I guess every single well working windows game since the dawn of time is 
some sort of anomaly then.

Cheers,
Con


--=_mimegpg-kolivas.org-26372-1141858802-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBED2HyZUg7+tp6mRURAp1hAJ9f8pmBYRpDjj1kEBbFZxftXnVHKwCfWmmO
lI0rL7qKkbCEE7UsHW5tpbo=
=64MO
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-26372-1141858802-0001--
