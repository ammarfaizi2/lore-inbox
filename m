Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVAQV1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVAQV1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVAQV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:27:13 -0500
Received: from server133-han.de-nserver.de ([81.3.17.173]:15774 "EHLO
	server133-han.de-nserver.de") by vger.kernel.org with ESMTP
	id S262877AbVAQV1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:27:02 -0500
Date: Mon, 17 Jan 2005 22:26:47 +0100
From: markus reichelt <ml@bitfalle.org>
To: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
Message-ID: <20050117212647.GA3754@dantooine>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-crypto@nl.linux.org
References: <41EAE36F.35354DDF@users.sourceforge.net> <41EB3E7E.7070100@tmr.com> <41EBD4D4.882B94D@users.sourceforge.net> <1105989298.14565.36.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <1105989298.14565.36.camel@ghanima>
Organization: still stuck in reorganization mode
X-PGP-Key: 0xC2A3FEE4
X-PGP-Fingerprint: FFB8 E22F D2BC 0488 3D56  F672 2CCC 933B C2A3 FEE4
X-Request-PGP: http://bitfalle.org/keys/c2a3fee4.asc
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fruhwirth Clemens <clemens@endorphin.org> wrote:
> This is FUD. To get serious in-depth information about the problems
> associated with dm-crypt and loop-aes read,
> 
> http://clemens.endorphin.org/LinuxHDEncSettings

excuse me, but that's just too academic for the end user. whatever
you're trying to say (apart from your obvious grudge against what
Jari is doing), it's not clear enough.

given the choices of dm-crypt, cryptoloop, and loop-aes it is awfully
clear what to use. your patches seem a bit like the cure to all and
everything which is suspicious like hell to me.


> This document has been reviewed by a couple of noteworthy people, also
> partially to counter the on-going FUD postings, Jari Ruusu has been
> posting to LKML repeatedly.

FUD crap for heaven's sake!

(i'm calming down, not given an example of the fuss about md5
collisions lately.... you're not applying double standards are you?!)

first of all, when whatever people review a document the document
itself is not understood any better afterwards than its virgin
cousin. as far as i'm concerned this whole silly review thing serves
the author's sleep but not the end user, so it could have been
reviewed by mickey.mouse@duck.tales.org for its comedy (or lack
thereof by jim.carey@fun.guaranteed.net) ;-)

i'm not saying it's wrong, it's just that ppl don't get it who should
according to your way of communicating the matter.

btw, just being curious, but did/do you have something to add to
this?

maybe you're still just missing Jari's point.

http://lkml.org/lkml/2004/5/16/71



http://marc.free.net.ph/message/20040726.181150.d4b819be.en.html

yes, we know you replied to that message at
http://marc.free.net.ph/message/20040726.225933.cb46c940.en.html. and
there it is again: as an ordinary user i take it that you claim to
understand what Jari's point is _all along_ but yet you both fail to
communicate that clearly during the beginning of a discussion
(repeatedly as google assures me - for the fun of it?) and you yet
acknowledge that Jari's claims are legit. might i inquire why you do
so (plain and simple please it can't be that hard)?

all i see is you giving the ordinary user of crypto on linux systems
the impression that Jari's claims are untrue, and one should follow
you the hero that brings back strong crypto to mainline. everyone
else is too stupid too realise that, and so, please get going ppl.
makes me sick :(

i'm not talking about loop-aes being the best there is, it's just
that loop-aes is getting the job done. cryptoloop and dm-crypt fail
to do so, and yet you bash loop-aes instead of contributing your
academic knowledge to the project providing the best solution for the
end user so far.

which makes me wonder, there are 3 different crypto implementations
and still you had to come up with yet another one instead of being
able to somehow work together with (at least) one of the existing
ones... because of technical issues? i doubt it. loop-aes could have
been the ideal testing platform for your stuff.


> James Morris: Can we please talk about the merge of my LRW patches soon?
> The insecurity of CBC based encryption such as dm-crypt and loop-aes is
> the reason why I have been pushing this patch so hard for the last two
> months now.

several weeks back i got the impression those patches were to be
included into mainline really soon. what's the delay?

by whom have these patches of yours been tested? for how long, in
which environment? etc. "reviewed by funny people the ordinary user
doesn't know and there's no link one can check up on them on the page
reviewed" doesn't count for me i'm afraid.

i'm gonna stick to loop-aes, and sorry for the rant but i'm just sick
of wasting energy this way, kids.

@clemens: i'm not bashing your work, i'm ranting from an end user's
point of view.

- -- 
Bastard Administrator in $hell

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB7C2XLMyTO8Kj/uQRAi/5AJ4osZKT/D29NoHfjIT/+2cnIZXMhQCfQ31N
09aQfmhB2pwJIU1kkx6Fyf4=
=cQZG
-----END PGP SIGNATURE-----
