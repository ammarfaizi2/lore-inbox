Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWCIEJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWCIEJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWCIEJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:09:57 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:25746 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751274AbWCIEJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:09:57 -0500
References: <200603081013.44678.kernel@kolivas.org> <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe> <200603081330.56548.kernel@kolivas.org> <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com> <cone.1141787137.882268.19235.501@kolivas.org> <1141852064.21958.28.camel@localhost> <cone.1141858802.179786.26372.501@kolivas.org> <1141861694.21958.66.camel@localhost> <cone.1141862870.463023.26372.501@kolivas.org> <1141874012.21958.138.camel@localhost>
Message-ID: <cone.1141877326.889550.27403.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Zan Lynx <zlynx@acm.org>
Cc: =?ISO-8859-1?B?QW5kcuk=?= Goddard Rosa <andre.goddard@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 09 Mar 2006 15:08:46 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-27403-1141877326-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-27403-1141877326-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Zan Lynx writes:

> On Thu, 2006-03-09 at 11:07 +1100, Con Kolivas wrote:
>> Games worked on windows for a decade on single core without real time 
>> scheduling because that's what they were written for. 
>> 
>> Now that games are written for windows with dual core they work well -
>> again 
>> without real time scheduling. 
>> 
>> Why should a port of these games to linux require real time?
> 
> That isn't what I said.  I said nothing about *requiring* anything, only
> about how to do it better.
> 
> Here is what Con said that I was disagreeing with.  All the rest was to
> justify my disagreement.  
> 
> Con said, "... games should _not_ need special scheduling classes. They
> are not written in a real time smart way and they do not have any
> realtime constraints or requirements."
> 
> And he said later, "No they shouldn't need real time scheduling to work
> well if they are coded properly."
> 
> Here is a list of simple statements of what I am saying:
> Games do have real-time requirements.
> The OS guessing about real-time priorities will sometimes get it wrong.
> Guessing task priority is worse than being told and knowing for sure.
> Games should, in an ideal world, be using real-time OS scheduling.
> Games would work better using real-time OS scheduling.

At the risk of  being repetitive to the point of tiresome, my point is that 
there are no real time requirements in games. You're assuming that 
everything will be better if we assume that there are rt requirements and 
that we're simulating pseudo real time conditions currently. That's just not 
the case and never has been. That's why it has worked fine for so long.

Cheers,
Con


--=_mimegpg-kolivas.org-27403-1141877326-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBED6pOZUg7+tp6mRURAlf7AJwIouBC/f6ERWGXbB8p+YdIjiBhwQCfQ+88
FxURRRcJbvW1YCO0UUu1qdQ=
=feUX
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-27403-1141877326-0001--
