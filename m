Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWBJFoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWBJFoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWBJFoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:44:24 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:19413 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751128AbWBJFoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:44:23 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
Date: Fri, 10 Feb 2006 15:40:56 +1000
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
References: <43E38BD1.4070707@openvz.org> <1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1642133.X4aiA4iKce";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602101541.07631.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1642133.X4aiA4iKce
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 04:37, Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> > On Mon, 2006-02-06 at 02:19 -0700, Eric W. Biederman wrote:
> >> That you placed the namespaces in a separate structure from
> >> task_struct.
> >> That part seems completely unnecessary, that and the addition of a
> >> global id in a completely new namespace that will be a pain to
> >> virtualize
> >> when it's time comes.
> >
> > Could you explain a bit why the container ID would need to be
> > virtualized?
>
> As someone said to me a little bit ago, for migration or checkpointing
> ultimately you have to capture the entire user/kernel interface if
> things are going to work properly.  Now if we add this facility to
> the kernel and it is a general purpose facility.  It is only a matter
> of time before we need to deal with nested containers.
>
> Not considering the case of having nested containers now is just foolish.
> Maybe we don't have to implement it yet but not considering it is silly.
>
> As far as I can tell there is a very reasonable chance that when we
> are complete there is a very reasonable chance that software suspend
> will just be a special case of migration, done complete in user space.
> That is one of the more practical examples I can think of where this
> kind of functionality would be used.

Am I missing something? I though migration referred only to userspace=20
processes. Software suspend on the other hand, deals with the whole system,=
=20
of which process data/context is only a part.

Regards,

Nigel

--nextPart1642133.X4aiA4iKce
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD7CdzN0y+n1M3mo0RApY3AKDVDudQK48i8jz7c0xW+MTe4ThBAgCfVBci
xtGWfEr+u9rgKYtzitfZsvE=
=KZIX
-----END PGP SIGNATURE-----

--nextPart1642133.X4aiA4iKce--
