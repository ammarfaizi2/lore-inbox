Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWBGABK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWBGABK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBGABK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:01:10 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:64644 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932419AbWBGABI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:01:08 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 09:57:34 +1000
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl>
In-Reply-To: <200602070051.41448.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1574471.Ij2scOnX1m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602070957.39712.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1574471.Ij2scOnX1m
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 09:51, Rafael J. Wysocki wrote:
> Hi,
>
> On Monday 06 February 2006 21:25, Nigel Cunningham wrote:
> > On Tuesday 07 February 2006 04:48, Lee Revell wrote:
> > > On Mon, 2006-02-06 at 15:43 +1000, Nigel Cunningham wrote:
> > > > Hi.
> > > >
> > > > On Monday 06 February 2006 14:34, Lee Revell wrote:
> > > > > On Mon, 2006-02-06 at 14:02 +1000, Nigel Cunningham wrote:
> > > > > > (they now have to download extra
> > > > > > libraries to use the splashscreen, which were not required
> > > > > > with the bootsplash patch, and need to check whether an update
> > > > > > to the userui code
> > > > > > is required when updating the kernel)
> > > > >
> > > > > You could have avoided this problem by keeping the
> > > > > userspace<->kernel interface stable.
> > > >
> > > > True, but sometimes you need to make changes that do modify the
> > > > interface. If the interface involves more functionality, this will
> > > > happen more frequently.
> > >
> > > Well, all I can say is, it should have been obvious that putting a
> > > themeable UI in the kernel would not fly.
> >
> > Agreed, but I think we have some confusion here.
> >
> > I was talking about interactions between kernel space and userspace
> > after we started using the userspace interface. In particular, I was
> > thinking of the fact that the netlink message number kept changing due
> > to changes in the vanilla kernel. In the end, we just made it a
> > command line option to the userui.
> >
> > My point for this conversation was different, though. If uswsusp ever
> > does fly, there are going to be flag days where users are going to
> > have to download new userspace code, perhaps new versions of libraries
> > or new libraries, run the compilation and reconfigure their
> > initrds/ram-fses, all just because they upgraded their kernel and want
> > to continue to suspend to disk. That is extra complexity introduced by
> > using a userspace 'brain' instead of having it in kernelspace.
>
> This point is valid, but I don't think the users will _have_ _to_ switch
> to the userland suspend.  AFAICT we are going to keep the kernel-based
> code as long as necessary.
>
> We are just going to implement features in the user space that need not
> be implemented in the kernel.  Of course they can be implemented in the
> kernel, and you have shown that clearly, but since they need not be
> there, we should at least try to implement them in the user space and
> see how this works.
>
> Frankly, I have no strong opinion on whether they _should_ be
> implemented in the user space or in the kernel, but I think we won't
> know that until we actually _try_.
>
> That said, I like the idea and I'm going to work on it.  I'll also
> appreciate any help very much.

Wow. I wish Pavel wrote replies like that. We'd get on a whole lot better.=
=20

Pavel, am I doing something wrong that I'm not clicking to, which is=20
stirring you up? I really don't want to. I want to work with you guys=20
instead of against you, but it seems to me like every attempt at=20
interaction with you degenerates into something far less than ideal.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1574471.Ij2scOnX1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5+JzN0y+n1M3mo0RAns+AJ9PZxrNKqAxigRtRcO7Xy+J/pbNmQCgjSHU
uoYSKH4l74K6xOdolkaZ82Q=
=M3gn
-----END PGP SIGNATURE-----

--nextPart1574471.Ij2scOnX1m--
