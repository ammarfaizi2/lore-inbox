Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVJCDKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVJCDKf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 23:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVJCDKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 23:10:35 -0400
Received: from smtp.enter.net ([216.193.128.24]:58124 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932123AbVJCDKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 23:10:35 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: what's next for the linux kernel?
Date: Sun, 2 Oct 2005 23:14:46 +0000
User-Agent: KMail/1.7.2
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
References: <20051002204703.GG6290@lkcl.net> <20051003015302.GP6290@lkcl.net> <Pine.LNX.4.58.0510021910230.21329@shell2.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0510021910230.21329@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1217550.iidfaNWv5o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510022314.51695.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1217550.iidfaNWv5o
Content-Type: multipart/mixed;
  boundary="Boundary-01=_nnGQDCesiZkZ1GJ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_nnGQDCesiZkZ1GJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 October 2005 02:31, Vadim Lobanov wrote:
> On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:
> > On Sun, Oct 02, 2005 at 06:20:38PM -0700, Vadim Lobanov wrote:
> > > On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:
> > > > On Sun, Oct 02, 2005 at 04:37:52PM -0700, Vadim Lobanov wrote:
> > > > > >  what if, therefore, someone comes up with an
> > > > > > architecture that is better than or improves greatly upon
> > > > > > SMP?
> > > > >
> > > > > Like NUMA?
> > > >
> > > >  yes, like numa, and there is more.
> > >
> > > The beauty of capitalization is that it makes it easier for
> > > others to read what you have to say.
> >
> >  sorry, vadim: haven't touched a shift key in over 20 years.
>
> It's not going to bite you. I promise.

You never know - someone might've rigged his keyboard to shock him=20
every time the shift key was pressed :)

<snip>
> > > >  the message passing system is designed as a parallel message
> > > > bus - completely separate from the SMP and NUMA memory
> > > > architecture, and as such it is perfect for use in
> > > > microkernel OSes.
> > >
> > > You're making an implicit assumption here that it will benefit
> > > _only_ microkernel designs.
> >
> >  ah, i'm not: i just left out mentioning it :)
> >
> >  the message passing needs to be communicated down to manage
> >  threads, and also to provide a means to manage semaphores and
> >  mutexes: ultimately, support for such an architecture would
> >  work its way down to libc.
> >
> >
> >  and yes, if you _really_ didn't want a kernel in the way at all,
> > you could go embedded and just... do everything yourself.
> >
> >  or port reactos, the free software reimplementation of nt,
> >  to it, or something :)
> >
> >  *shrug*.
>
> No, for reliability and performance reasons, I very much want a
> kernel in the way. After all, kernel code is orders of magnitude
> better tuned than almost all userland code.
>
> The point I was making here is that, from what I can see, the
> current Linux architecture is quite alright in anticipation of the
> hardware that you're describing. It _could_ be better tuned for
> such hardware, sure, but so far there is no need for such work at
> this particular moment.

Wholly agreed. The arguments over the benefits of running a=20
microkernel aren't ever really clear. Beyond that, I personally feel=20
that the whole micro vs. mono argument is a catfight between=20
academics. I'd rather have a system that works and is proven than a=20
system that is bleeding edge and never truly stable.  To me this=20
means a monolithic kernel - microkernels are picky at best, and can=20
be highly insecure (and that means "unstable" in my book too).

<snip>
> > > >  however, as i pointed out, 90nm and approx-2Ghz is pretty
> > > > much _it_, and to get any faster you _have_ to go parallel.
> > >
> > > Sure, it's going to stop somewhere, but you have to be a heck
> > > of a visionary to predict that it will stop _there_.
> >
> >  okay, i admit it: you caught me out - i'm a mad visionary.
> >
> >  but seriously.
> >
> >  it won't stop - but the price of 90nm mask charges, at approx
> >  $2m, is already far too high, and the number of large chips
> >  being designed is plummetting like a stone as a result - from
> >  like 15,000 per year a few years ago down to ... damn, can't
> > remember - less than a hundred (i think!  don't quote me on
> > that!)
> >
> >  when 90 nm was introduced, some mad fabs wanted to make 9
> >  metre lenses, dude!!! until carl zeiss were called in and
> >  managed to get it down to 3 metres.
> >
> >  and that lens is produced on a PER CHIP basis.
> >
> >  basically, it's about cost.
>
> I can guarantee one thing here -- the cost, as is, is absolutely
> bearable. These companies make more money doing this than they
> spend in doing it, otherwise they wouldn't be in business. From an
> economics perspective, this industry is very much alive and well,
> proven by the fact that these companies haven't bailed out of it
> yet.

I have to agree. And he is also completely ignoring the fact that both=20
Intel and AMD are either in the process of moving to (or have moved=20
to)  a 65nm fab process - last news I saw about this said both=20
facilities were running into the multi-billion dollar cost range.=20
Companies worried about $2m for a mask charge wouldn't be investing=20
multiple billions of dollars in new plants and a new, smaller fab=20
process.

<snip>
> > > >  and the drive for "faster", "better", "more sales" means
> > > > more and more parallelism.
> > > >
> > > >  it's _happening_ - and SMP ain't gonna cut it (which is why
> > > >  these multi-core chips are coming out and why hyperthreading
> > > >  is coming out).
> > >
> > > "Rah, rah, parallelism is great!" -- That's a great slogan,
> > > except...
> > >
> > > Users, who also happen to be the target of those sales, care
> > > about _userland_ applications. And the bitter truth is that the
> > > _vast_ majority of userland apps are single-threaded. Why? Two
> > > reasons -- first, it's harder to write a multithreaded
> > > application, and second, some workloads simply can't be
> > > expressed "in parallel". Your kernel might (might, not will)
> > > run like a speed-demon, but the userland stuff will still be
> > > lackluster in comparison.
> > >
> > > And that's when your slogan hits a wall, and the marketing hype
> > > dies. The reality is that parallelism is something to be
> > > desired, but is not always achievable.
> >
> >  okay: i will catch up on this bit, another time, because it is
> > late enough for me to be getting dizzy and appearing to be drunk.
> >
> >  this is one answer (and there are others i will write another
> > time. hint: automated code analysis tools, auto-parallelising
> > tools, both offline and realtime):
>
> We don't need hints. We need actual performance statistics --
> verifiable numbers that we can point to and say "Oh crap, we're
> losing." or "Hah, we kick butt.", as the case may be.

Hear, hear!  I'm still working my way through the source tree and=20
learning the general layout and functionality of the various bits,=20
but in just a pair of months of being on this list I can attest to=20
the fact that one thing all developers seem to ask for is statistics.

<snip>
> At the risk of stepping on some toes, I believe that hyperthreading
> is going out of style, in favor of multi-core processors.

Agreed. And multi-core processors aren't really new technology - there=20
have been multi-core designs out for a while, but those were usually=20
low production "research" chips.

DRH

--Boundary-01=_nnGQDCesiZkZ1GJ
Content-Type: application/pgp-keys;
  name="OpenPGP key 0xA6992F96300F159086FF28208F8280BB8B00C32A"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0xA6992F96300F159086FF28208F8280BB8B00C32A.asc

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.7 (GNU/Linux)

mQGiBEJS3C0RBADeLmOaFYR40Pd/n86pPD10DYJIiSuEEJJAovJI/E3kjYgKnom0
CmwPa9oEXf4B3FMVcqB0ksKrhA8ECVsNRwO91+LObFczyc59XBgYDScn9h9t+lu4
IZTObcR1SnQ/I+YdeJpd12ZcuLAnQ3EGl9+7bBOJgr4JcwM6Idixtg92kwCg4vhj
97BpUqPSk6cwD4LMRoqzABcEAJPZdEpYDwrXiy5aQx8ax+CbdfJX+XhxVcOrqzoI
8TS7yZPcE1rszCANpCb6xg7TReWyIOu+FQvfzLg5e7Cl2XtVC66RDgdlTBy/pjnX
fxIOIW5Hl+cVaWLBJ2tdAOIiyGPrKC/uTyY/N+4iQTsQK2l/yxc3fOgEN0g9AY9a
GSkHBACmX6awLcrdnxY0p2J/OmRtT4oOWcbq5TUchM9SzPLLIatGZEs7jUal9OYo
ZzmRPjElgM4koF7TTB+71FTUaqVGd0smJVKfJ1nVp6nefxOI6MH/v8/4j7Bvtb1Y
Ypkrxt+R8WWUI1L19yEDp55rvzqIkkLtmJZP/QJg2e7zxTYYi7Q5RGFuaWVsIFIu
IEhhemVsdG9uIChUaGUgU2hhZG93V29sZikgPGRoYXplbHRvbkBlbnRlci5uZXQ+
iF4EExECAB4FAkJS3C0CGwMGCwkIBwMCAxUCAwMWAgECHgECF4AACgkQj4KAu4sA
wyoRwwCeN+PEM8jpxxpxiG4dGyXNwTZBtNkAoKAtdOgeK66+zPEtJFanUeFe6lRX
uQENBEJS3DoQBACfejnq7GSJ7g8nL669pXDVFFrabOaiIC4sH0FgqbK+Oewm4h77
Ir5QL9SsHWvYSBYxnCODvR7zHv8HefWgJ4duC66b8PCXY/qcmxhRhYtdEssx/ncm
BhNXlPPvsyPT/e7PdZkDv7dJuVtVJrLVVeSniz+3KBIIYb395B+yhzjPLwAEDQP9
HFlaX9Duyg8c+RFhqStVrIluy7ZTg8pGjF2KLPsCmcSVzVLLhplF1M6Fs1CSgwRe
OCDRWPFohcaSxPIwIdlS0h2HOnWziPVpzh4HWylbtC6cZYg7dpgaDlJA00ikUlyj
6/bxwNwBuVoNSegIe0mN+xAIsvXM2TLuY1fFYcmeRxmISQQYEQIACQUCQlLcOgIb
DAAKCRCPgoC7iwDDKsoRAJwKJETliGVgcCSTMd7sq/WMOe9VAgCgxq4MRqWBvPWY
fPs99FjiIC8asFc=
=vwF/
-----END PGP PUBLIC KEY BLOCK-----

--Boundary-01=_nnGQDCesiZkZ1GJ--

--nextPart1217550.iidfaNWv5o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDQGnrj4KAu4sAwyoRAuYPAJ0azFX89JhifTPsiJq5sDJq4OomeACeKESC
+PhnxrIY1MmFvjrvFWWPYZE=
=OvwE
-----END PGP SIGNATURE-----

--nextPart1217550.iidfaNWv5o--
